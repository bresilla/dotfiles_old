import ranger.api

import os
import os.path
import signal

old_hook_init = ranger.api.hook_init
def hook_init(fm):
    try:
        # Get the PID of the associated shell.
        texas_shell_pid = int(os.environ['TEXAS_SHELL_PID'])

        # Bind the 'cd' signal to a function sending the ranger's cwd
        # to the associated shell.
        def ranger_to_sh_sync(sig):
            try:
                os.kill(texas_shell_pid, signal.SIGUSR1)
                if 'TEXAS_BASH' in os.environ:
                    # Force Bash to refresh the prompt.
                    # See: https://github.com/Vifon/texas/issues/1
                    os.kill(texas_shell_pid, signal.SIGINT)
            except OSError:
                exit(0)
        fm.signal_bind(
            'cd',
            ranger_to_sh_sync)

        # Handle the SIGUSR1 signal.
        def sh_to_ranger_sync(sig, frame):
            cwd = "/proc/{}/cwd".format(texas_shell_pid)
            fm.cd(os.path.realpath(cwd))
        signal.signal(
            signal.SIGUSR1,
            sh_to_ranger_sync)

        # If a new tmux session needed to be created i.e. texas wasn't
        # started from inside of tmux.
        if int(os.environ['LAUNCH_TEXAS']):
            # Close the associated shell along with the whole texas on
            # ranger exit unless it was started inside of an existing
            # tmux session.
            import atexit
            def texas_cleanup():
                os.kill(texas_shell_pid, signal.SIGHUP)
            atexit.register(texas_cleanup)
        # Prevent the child processes from inheriting this env var so
        # that the spawned shells will not start nested texases
        # immediately.
        del os.environ['LAUNCH_TEXAS']
    except KeyError:
        # The texas shell is not running.
        pass
    finally:
        return old_hook_init(fm)

ranger.api.hook_init = hook_init
