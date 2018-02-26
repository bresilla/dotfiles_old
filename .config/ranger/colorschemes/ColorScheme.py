from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class ColorScheme(ColorScheme):

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                fg = 6
                bg = 1
            if context.border:
                fg = white
            if context.image:
                fg = 201
            if context.video:
                fg = 13
            if context.audio:
                fg = 10
            if context.document:
                fg = 12
            if context.container:
                attr |= bold
                fg = 1
            if context.directory:
                attr |= normal
                fg = 3
            elif context.executable and not \
                    any((context.media, context.container,
                       context.fifo, context.socket)):
                attr |= bold
                fg = 2
            if context.socket:
                fg = 21
                attr |= bold
            if context.fifo or context.device:
                fg = 21
                if context.device:
                    attr |= bold
            if context.link:
                fg = context.good and 6 or 1
            if context.bad:
                fg = 0
                bg = 1
            if context.tag_marker and not context.selected:
                attr |= bold
                fg = 88
            if not context.selected and (context.cut or context.copied):
                attr = reverse
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = 8
            if context.badinfo:
                if attr & reverse:
                    bg = 1
                else:
                    fg = 7

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                fg = context.bad and 1 or 5
            elif context.directory:
                fg = 5
            elif context.tab:
                if context.good:
                    bg = 2

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = 2
                    bg = 0
                elif context.bad:
                    fg = 1
            if context.marked:
                attr |= bold | reverse
                fg = 88
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = 9
            if context.loaded:
                bg = 1


        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = 4

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = 1
                else:
                    bg = 1

        return fg, bg, attr
