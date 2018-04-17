# ?????? ?????????
import bpy
import bmesh
from math import degrees
from mathutils import Vector, kdtree
from bpy_extras import view3d_utils
from bpy.props import StringProperty
import blf
import bgl
import os
from bpy.props import IntProperty, FloatProperty
#import win32api
bl_info = {
	"name": "Destructive Extrude :)",
	"location": "View3D > Add > Mesh > Destructive Extrude,",
	"description": "Extrude how SketchUp.",
	"author": "Vladislav Kindushov",
	"version": (0, 8, 9),
	"blender": (2, 7, 8),
	"category": "Mesh",
}

def RayCast(self, context, event, ray_max=1000.0):
	"""Run this function on left mouse, execute the ray cast"""
	# get the context arguments
	scene = context.scene
	region = context.region
	rv3d = context.region_data
	coord = event.mouse_region_x, event.mouse_region_y

	# get the ray from the viewport and mouse
	view_vector = view3d_utils.region_2d_to_vector_3d(region, rv3d, coord).normalized()
	ray_origin = view3d_utils.region_2d_to_origin_3d(region, rv3d, coord)

	ray_target = ray_origin + view_vector

	def visible_objects_and_duplis():
		"""Loop over (object, matrix) pairs (mesh only)"""

		for obj in context.visible_objects:
			if obj.type == 'MESH':
				yield (obj, obj.matrix_world.copy())

			if obj.dupli_type != 'NONE':
				obj.dupli_list_create(scene)
				for dob in obj.dupli_list:
					obj_dupli = dob.object
					if obj_dupli.type == 'MESH':
						yield (obj_dupli, dob.matrix.copy())

			obj.dupli_list_clear()

	def obj_ray_cast(obj, matrix):
		"""Wrapper for ray casting that moves the ray into object space"""

		# get the ray relative to the object
		matrix_inv = matrix.inverted()
		ray_origin_obj = matrix_inv * ray_origin
		ray_target_obj = matrix_inv * ray_target
		ray_direction_obj = ray_target_obj - ray_origin_obj
		d = ray_direction_obj.length

		ray_direction_obj.normalize()

		success, location, normal, face_index = obj.ray_cast(ray_origin_obj, ray_direction_obj)

		if face_index != -1:
			return location, normal, face_index
		else:
			return None, None, None

	# cast rays and find the closest object
	best_length_squared = -1.0
	best_obj = None
	best_matrix = None
	best_face = None
	best_hit = None

	for obj, matrix in visible_objects_and_duplis():
		if obj.type == 'MESH':

			hit, normal, face_index = obj_ray_cast(obj, matrix)
			if hit is not None:
				hit_world = matrix * hit
				scene.cursor_location = hit_world
				length_squared = (hit_world - ray_origin).length_squared
				if best_obj is None or length_squared < best_length_squared:
					best_length_squared = length_squared
					best_obj = obj
					best_matrix = matrix
					best_face = face_index
					best_hit = hit
					break

	def run(best_obj, best_matrix, best_face, best_hit):
		best_distance = float("inf")  # use float("inf") (infinity) to have unlimited search range

		mesh = best_obj.data
		best_matrix = best_obj.matrix_world
		for vert_index in mesh.polygons[best_face].vertices:
			vert_coord = mesh.vertices[vert_index].co
			distance = (vert_coord - best_hit).magnitude
			if distance < best_distance:
				best_distance = distance
				scene.cursor_location = best_matrix * vert_coord

		for v0, v1 in mesh.polygons[best_face].edge_keys:
			p0 = mesh.vertices[v0].co
			p1 = mesh.vertices[v1].co
			p = (p0 + p1) / 2
			distance = (p - best_hit).magnitude
			if distance < best_distance:
				best_distance = distance
				scene.cursor_location = best_matrix * p

		face_pos = Vector(mesh.polygons[best_face].center)
		distance = (face_pos - best_hit).magnitude
		if distance < best_distance:
			best_distance = distance
			scene.cursor_location = best_matrix * face_pos

	run(best_obj, best_matrix, best_face, best_hit)

def firstD(context):

	act_obj = bpy.context.active_object

	sf = [i.index for i in bmesh.from_edit_mesh(act_obj.data).faces if i.select]

	bpy.ops.object.mode_set(mode='OBJECT')
	bpy.ops.object.select_all(action='DESELECT')
	bpy.ops.object.mode_set(mode='EDIT')
	bpy.ops.mesh.duplicate_move(MESH_OT_duplicate={"mode": 1})
	bpy.ops.mesh.separate(type='SELECTED')

	bpy.ops.object.mode_set(mode='OBJECT')

	sel_obj = bpy.context.selected_objects
	object_B = None
	object_B_Name = None
	for i in sel_obj:
		object_B_Name = i.name
		object_B = i
		break

	bpy.ops.object.select_all(action='DESELECT')
	bpy.ops.object.mode_set(mode='EDIT')

	bm = bmesh.from_edit_mesh(act_obj.data)
	bm.faces.ensure_lookup_table()
	for i in sf:
		bm.faces[i].select = True
	return object_B
	#bmesh.update_edit_mesh(obj.data)
	#bm.free()

def Duplicate(self, context, act_obj):
	"""Create 2 copy selection. the firs orygnal posisiton. the second modifi"""
	main_select_obj = bpy.context.selected_objects
	object_B = firstD(context)
	print(object_B)
	bm = bmesh.from_edit_mesh(act_obj.data)
	face = [f for f in bm.faces if f.select]  # get select faces
	angle = 0.0
	save_pos = {}
	distance = -0.000002
	for i in face:#?? ??????
		for edge in i.edges:# ?? ?????? ??? ?????
			angle = edge.calc_face_angle_signed()# ??????? ????
			angle = degrees(angle)# ????????? ???? ? ???????????? ???
			if angle > 89.99:# ???? 90 ????????1
				vert1, vert2 = edge.verts# ??????? ??????? ???? ????????
				if not vert1.index in save_pos:
					save_pos[vert1.index] = vert1.co.copy()
				if not vert2.index in save_pos:
					save_pos[vert2.index] = vert2.co.copy()

				# ??????? ???? ?????, ??? ?????? ??????? ?????, ???? ????? ???? ??? ??? ??????
				link1 = vert1.link_edges
				link2  = vert2.link_edges
				for l in link1:
					for e in i.edges:
						if l == e and not l == edge:
							V1, V2 = l.verts
							vec = V2.co
							#if V1 == vert1:
							vec = V2.co - V1.co
							if V2 == vert1:
								vec = V1.co - V2.co
							vec.normalize()
							vert1.co += vec * distance
				for l in link2:
					for e in i.edges:
						if l == e and not l == edge:
							V1, V2 = l.verts
							vec = V2.co
							if V1 == vert2:
								vec = V2.co - V1.co
							if V2 == vert2:
								vec = V1.co - V2.co
							vec.normalize()
							vert2.co += vec * distance

	bpy.ops.mesh.duplicate_move(MESH_OT_duplicate={"mode": 1})

	bm.verts.ensure_lookup_table()
	for key, value in save_pos.items():
		bm.verts[key].co = value

	bmesh.update_edit_mesh(act_obj.data)
	bm.free()

	bpy.ops.mesh.separate(type='SELECTED')
	bpy.ops.object.mode_set(mode='OBJECT')

	sel_obj = bpy.context.selected_objects
	object_C = None
	object_C_Name = None
	for i in sel_obj:
		object_C_Name = i.name
		object_C = i
		break

	for i in main_select_obj:
		i.select = True
	print(object_B)
	print(object_C)

	return object_B, object_C

def HideModeifiers(context, obj):
	"""Hide modifiers"""
	desable_modifier = []
	for i in obj.modifiers:
		if i.show_viewport == True:
			desable_modifier.append(i)
		i.show_viewport = False
	return desable_modifier

def GetB_obj(self, context):
	'''Get sepatare object'''
	sel_obj = bpy.context.selected_objects
	object_B = None
	object_B_Name = None
	for i in sel_obj:
		object_B_Name = i.name
		object_B = i
		break

	return object_B

def SetupObjB(self, context, object_B_Name, f = False):
	"""Setup objectB """
	context.scene.objects.active = bpy.data.objects[object_B_Name]

	bpy.ops.object.modifier_add(type='SOLIDIFY')

	for i in bpy.data.objects[object_B_Name].modifiers:
		if i.type == 'SOLIDIFY':
			i.use_even_offset = True
	bpy.data.objects[object_B_Name].hide = True


def SetupBoolean(self, context, obj_A, obj_B):
	"""Add modifier boolean for the first object"""
	context.scene.objects.active = bpy.data.objects[obj_A.name]
	bpy.ops.object.modifier_add(type='BOOLEAN')
	for i in obj_A.modifiers:
		if i.type == 'BOOLEAN' and i.show_viewport:
			i.operation = 'DIFFERENCE'
			i.object = obj_B
			i.solver = 'CARVE'

def RemoveModifier(self, context, obj):
	"""Remove modifier"""
	context.scene.objects.active = bpy.data.objects[obj.name]
	for i in obj.modifiers:
		bpy.ops.object.modifier_remove(modifier=i.name)

def CrateKD(context,obj):
	"""Create KDTree"""
	size = len(obj.data.vertices)
	kd = kdtree.KDTree(size)
	for i, vtx in enumerate(obj.data.vertices):
		kd.insert(vtx.co, i)
	kd.balance()
	return kd

def Setup(self, context):
	"""Main function for invoke"""

	modifiers_list = None
	select_objects = None
	object_A = context.active_object
	object_Negative = None
	object_Positive = None
	kd = None

	object_Negative, object_Positive = Duplicate(self, context, object_A)



	modifiers_list = HideModeifiers(context, object_A)

	#object_Negative = GetB_obj(self, context)
	#object_Positive = GetB_obj(self, context)

	SetupBoolean(self, context, object_A, object_Negative)
	#print(object_Negative)
	#print(object_Positive)

	RemoveModifier(self, context, object_Negative)
	RemoveModifier(self, context, object_Positive)

	SetupObjB(self, context, object_Negative.name)
	SetupObjB(self, context, object_Positive.name)
	kd = CrateKD(context,object_Negative)

	object_Negative.name = 'Negative'
	object_Positive.name = 'Positive'

	ver = []
	ver.append(object_A)
	ver.append(object_Positive)
	ver.append(object_Negative)
	ver.append(modifiers_list)
	ver.append(select_objects)
	ver.append(kd)

	return ver

def StarPosMouse(self, context, event):
	scene = context.scene
	region = context.region
	rv3d = context.region_data
	coord = event.mouse_region_x, event.mouse_region_y
	view_vector = view3d_utils.region_2d_to_vector_3d(region, rv3d, coord)
	loc = view3d_utils.region_2d_to_location_3d(region, rv3d, coord, view_vector)

	normal = self.var[2].data.polygons[0].normal
	loc = ((normal * -1) * loc)
	return loc

def SwitchMesh(context,var):
	"""Switch in a object boolean source a mesh"""
	if var[1].modifiers['Solidify'].thickness < 0.0:
		for i in var[0].modifiers:
			if i.show_viewport == True and i.type == 'BOOLEAN':
				if i.object != var[2]:
					i.object = var[2]
					i.operation = 'UNION'

					#bpy.data.objects[var[2].name].hide = True
					return True

	elif var[1].modifiers['Solidify'].thickness > 0.0:
		for i in var[0].modifiers:
			if i.show_viewport == True and i.type == 'BOOLEAN':
				if i.object != var[1]:
					i.object = var[1]
					i.operation = 'DIFFERENCE'
					#bpy.data.objects[var[1].name].hide = True
					#bpy.data.objects[var[2].name].hide = True

					return False

	elif var[1].modifiers['Solidify'].thickness == 0.0:
		for i in var[0].modifiers:
			if i.show_viewport == True and i.type == 'BOOLEAN':
				i.object = None

def EventMouse(self, context, event, obj):
	scene = context.scene
	region = context.region
	rv3d = context.region_data
	coord = event.mouse_region_x, event.mouse_region_y
	view_vector = view3d_utils.region_2d_to_vector_3d(region, rv3d, coord)
	loc = view3d_utils.region_2d_to_location_3d(region, rv3d, coord, view_vector)
	#print('sisisissisisisisis',loc)
	#print('p3ipiipipipipipipipi' , self.var[0].scale)
	normal = obj[2].data.polygons[0].normal
	#loc = (loc / self.var[0].scale) * (normal * -1) - self.start_mouse
	#print('asdfsadfsadf',loc)
	area= Zoom(self, context)
	#print ('area = ', area)
	loc = (((normal * -1) * loc ) - self.start_mouse) / area

	loc *= 10


	self.var[1].modifiers['Solidify'].thickness = loc
	self.var[2].modifiers['Solidify'].thickness = loc

	SwitchMesh(context, obj)

	if self.temp_key:
		self.key = str(loc)


def EventCtrl(self, context,event, var):
	try:
		RayCast(self, context, event)
	except:
		pass

	temp = SwitchMesh(context, var)
	mat = None
	if temp:
		mat = var[1].matrix_world
		mat = mat.inverted()
	else:
		mat = var[2].matrix_world
		mat = mat.inverted()

	dist = var[-1].find(mat * context.scene.cursor_location)

	pos1	= None
	pos2	= None

	if temp:
		pos1 = var[1].data.vertices[dist[1]].co
		pos2 = mat * context.scene.cursor_location
	else:
		pos1 = var[2].data.vertices[dist[1]].co
		pos2 = mat * context.scene.cursor_location

	bm = bmesh.new()
	me = bpy.data.meshes.new("Mesh")
	bm.to_mesh(me)
	A = bm.verts.new(pos1)
	bm.to_mesh(me)
	B = bm.verts.new(pos2)
	bm.to_mesh(me)
	V = bm.edges.new((A, B))
	bm.to_mesh(me)

	scene = bpy.context.scene
	obj = bpy.data.objects.new("Length", me)
	scene.objects.link(obj)

	bm.to_mesh(me)

	bm.edges.ensure_lookup_table()
	lenn = bm.edges[0].calc_length()

	bm.to_mesh(me)
	bm.free()

	bpy.context.scene.objects.unlink(obj)
	bpy.data.objects.remove(obj)

	for i in var[0].modifiers:
			if i.show_viewport == True and i.type == 'BOOLEAN':
				if i.object == var[2]:

					var[2].modifiers['Solidify'].thickness = lenn*-1
				else:
					var[1].modifiers['Solidify'].thickness = lenn

	SwitchMesh(context, var)

	if self.temp_key:
		self.key = str(lenn)

def draw_callback_px(self, context):
	width = None
	for region in bpy.context.area.regions:
		if region.type == "TOOLS":
			width = region.width
			break

	font_id = 0



	bgl.glColor4f(1, 1, 1, 0.5)
	blf.position(font_id, width + 15, 60, 0)
	blf.size(font_id, 20, 72)
	blf.draw(font_id, "Offset: ")
	blf.position(font_id,  width+85, 60, 0)
	blf.size(font_id, 20, 72)
	if self.draw:
		blf.draw(font_id, self.key)
	else:
		if self.var[1].modifiers['Solidify'].thickness < 0.0:
			blf.draw(font_id, self.key[:6])
		else:
			blf.draw(font_id, self.key[:5])



	# restore opengl defaults
	bgl.glDisable(bgl.GL_BLEND)
	bgl.glColor4f(0.0, 0.0, 0.0, 1.0)



def Finish(self, context, f = False):
	context.scene.objects.active = bpy.data.objects[self.var[0].name]
	for i in self.var[0].modifiers:
		if i.show_viewport == True and i.type == 'BOOLEAN':
			a = i.name
			bpy.ops.object.modifier_apply(modifier = i.name)

			#bpy.data.objects[self.var[0].name].modifiers.apply(i)

	bpy.data.objects[self.var[0].name].show_wire = self.show_wire
	bpy.data.objects[self.var[0].name].show_all_edges = self.show_all_edges


	bpy.context.scene.objects.unlink(self.var[1])
	bpy.data.objects.remove(self.var[1])
	bpy.context.scene.objects.unlink(self.var[2])
	bpy.data.objects.remove(self.var[2])

	for i in self.var[0].modifiers:
		if i in self.var[3]:
			i.show_viewport = True


	bpy.ops.object.mode_set(mode='EDIT')
	bpy.data.scenes['Scene'].tool_settings.use_mesh_automerge = self.auto_snap
	bpy.ops.mesh.select_all(action='SELECT')
	bpy.ops.mesh.remove_doubles()
	bpy.ops.mesh.select_all(action='DESELECT')

	if f:
		bpy.ops.mesh.edges_select_sharp()
		bpy.ops.transform.edge_bevelweight(value=1)
		bpy.ops.mesh.select_all(action='DESELECT')

def Cansl(self, context):
	context.scene.objects.active = bpy.data.objects[self.var[0].name]
	for i in self.var[0].modifiers:
		if i.show_viewport == True and i.type == 'BOOLEAN':
			bpy.data.objects[self.var[0].name].modifiers.remove(i)

	bpy.data.objects[self.var[0].name].show_wire = self.show_wire
	bpy.data.objects[self.var[0].name].show_all_edges = self.show_all_edges

	bpy.context.scene.objects.unlink(self.var[1])
	bpy.data.objects.remove(self.var[1])
	bpy.context.scene.objects.unlink(self.var[2])
	bpy.data.objects.remove(self.var[2])

	for i in self.var[0].modifiers:
		if i in self.var[3]:
			i.show_viewport = True

	bpy.ops.object.mode_set(mode='EDIT')

def Zoom(self, context):
	ar = None
	for i in bpy.context.window.screen.areas:
		if i.type=='VIEW_3D': ar = i

	ar = ar.spaces[0].region_3d.view_distance
	print(ar)
	return ar


#--------------------------------------------------------------------------------#

class DestructiveExtrude(bpy.types.Operator):
	bl_idname = "mesh.destructive_extrude"
	bl_label = "Destructive Extrude"
	bl_options = {"REGISTER", "UNDO", "GRAB_CURSOR", "BLOCKING"}

	first_mouse_x = IntProperty()
	first_value = FloatProperty()

	@classmethod
	def poll(cls, context):
		return (context.mode == "EDIT_MESH")#and (context.tool_settings.mesh_select_mode == (False, False, True))
		#return (context.active_object is not None) and (context.mode == "EDIT_MESH")

	# -----------------------------------------------------------------------------------------------
	def modal(self, context, event):
		SwitchMesh(context, self.var)

		if event.type in {'MIDDLEMOUSE', 'WHEELUPMOUSE', 'WHEELDOWNMOUSE', 'LEFTMOUSE', 'RIGHTMOUSE'} and (
			event.alt or event.shift):
			return {'PASS_THROUGH'}

		if event.type == 'MOUSEMOVE':
			EventMouse(self, context, event, self.var)
			context.area.tag_redraw()

		if event.ctrl:
			EventCtrl(self, context, event, self.var)
			context.area.tag_redraw()

		if event.unicode in self.enter:
			if self.draw == False:
				self.temp_key = False
				self.draw = True
				temp = ''
				self.key = temp
			if event.unicode == ',':
				self.key += '.'
			else:
				self.key += event.unicode
				context.area.tag_redraw()

		if event.type == 'BACK_SPACE':
			temp = self.key[:-1]
			self.key = temp
			s = ['+', '-', '*', '/', '.']
			if self.key[:-1] in s:
				temp = self.key[:-1]
				self.key = temp
			context.area.tag_redraw()

		if event.type in {'RET', 'NUMPAD_ENTER'}:
			if not self.temp_key:
				self.var[1].modifiers['Solidify'].thickness = float(eval(self.key))
				self.var[2].modifiers['Solidify'].thickness = float(eval(self.key))
				bpy.types.SpaceView3D.draw_handler_remove(self._handle, 'WINDOW')
				context.area.tag_redraw()
				context.area.header_text_set()
				Finish(self, context)
				return {'FINISHED'}

		if event.type == 'LEFTMOUSE':
			bpy.types.SpaceView3D.draw_handler_remove(self._handle, 'WINDOW')
			context.area.tag_redraw()
			context.area.header_text_set()
			Finish(self, context)
			return {'FINISHED'}

		if event.type == 'SPACE':
			self.var[1].modifiers['Solidify'].thickness = float(eval(self.key))
			self.var[2].modifiers['Solidify'].thickness = float(eval(self.key))
			bpy.types.SpaceView3D.draw_handler_remove(self._handle, 'WINDOW')
			context.area.tag_redraw()
			context.area.header_text_set()
			Finish(self, context, True)
			return {'FINISHED'}


		if event.type == 'RIGHTMOUSE':
			bpy.types.SpaceView3D.draw_handler_remove(self._handle, 'WINDOW')
			context.area.tag_redraw()
			context.area.header_text_set()
			Cansl(self, context)
			return {'CANCELLED'}

		if event.type in {'ESC'}:
			bpy.types.SpaceView3D.draw_handler_remove(self._handle, 'WINDOW')
			context.area.tag_redraw()
			context.area.header_text_set()
			Cansl(self, context)
			return {'CANCELLED'}

		return {'RUNNING_MODAL'}

	def invoke(self, context, event):
		if context.space_data.type == 'VIEW_3D':
			self.auto_snap =  bpy.data.scenes['Scene'].tool_settings.use_mesh_automerge
			bpy.data.scenes['Scene'].tool_settings.use_mesh_automerge = False
			self.var = Setup(self, context)
			self.show_wire = bpy.data.objects[self.var[0].name].show_wire
			self.show_all_edges = bpy.data.objects[self.var[0].name].show_all_edges

			self.enter = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '+', '*', '/', '.', ',']

			self.start_mouse = StarPosMouse(self, context, event)


			args = (self, context)
			self._handle = bpy.types.SpaceView3D.draw_handler_add(draw_callback_px, args, 'WINDOW', 'POST_PIXEL')
			self.key = ""
			self.temp_key = True
			self.draw = False

			bpy.data.objects[self.var[0].name].show_wire = True
			bpy.data.objects[self.var[0].name].show_all_edges = True

			context.window_manager.modal_handler_add(self)
			return {'RUNNING_MODAL'}
		else:
			self.report({'WARNING'}, "is't 3dview")
			return {'CANCELLED'}

def operator_draw(self,context):
	layout = self.layout
	col = layout.column(align=True)
	self.layout.operator_context = 'INVOKE_REGION_WIN'
	col.operator("mesh.destructive_extrude", text="Destructive Extrude")

def register():
	bpy.utils.register_class(DestructiveExtrude)
	bpy.types.VIEW3D_MT_edit_mesh_extrude.append(operator_draw)



def unregister():
	bpy.utils.unregister_class(DestructiveExtrude)
	bpy.types.VIEW3D_MT_edit_mesh_extrude.remove(operator_draw)



if __name__ == "__main__":
	register()

