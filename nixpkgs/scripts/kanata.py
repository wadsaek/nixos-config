from subprocess import run

keyboard = "kanata-internalKeyboard.service"
ctl = "systemctl"
status = run(
        [ctl, "is-active", keyboard],
        capture_output=True
        ).stdout.decode()


if status == "active\n":
    run([ctl, "stop", keyboard])
else:
    run([ctl, "start", keyboard])
