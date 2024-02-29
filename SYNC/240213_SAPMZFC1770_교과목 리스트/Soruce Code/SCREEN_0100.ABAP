PROCESS BEFORE OUTPUT.
  MODULE status_0100.
  MODULE set_alv_0100.

PROCESS AFTER INPUT.
  MODULE exit AT EXIT-COMMAND.
  CHAIN.
    FIELD zsfc17070-subid_fr.
    FIELD zsfc17070-subid_to.
    MODULE change_parameters ON CHAIN-REQUEST.
  ENDCHAIN.
  MODULE user_command_0100.