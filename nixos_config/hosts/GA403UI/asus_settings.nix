{ config, pkgs, lib, inputs, outputs, pkgs_unstable, ... }:

{
  # Default to using iGPU. Can use CLI to enable dGPU with a logout
  services.supergfxd.settings = {
      mode = "Integrated";
      vfio_enable = true;
      vfio_save = false;
      always_reboot = false;
      no_logind = false;
      logout_timeout_s = 180;
      hotplug_type = "None";
  };

  environment.etc."asusd/asusd.ron" = {
    text = ''
    (
        charge_control_end_threshold: 80,
        disable_nvidia_powerd_on_battery: true,
        ac_command: "",
        bat_command: "",
        platform_profile_linked_epp: true,
        platform_profile_on_battery: Quiet,
        change_platform_profile_on_battery: true,
        platform_profile_on_ac: Balanced,
        change_platform_profile_on_ac: true,
        profile_quiet_epp: Power,
        profile_balanced_epp: BalancePower,
        profile_performance_epp: Performance,
        ac_profile_tunings: {
            Quiet: (
                enabled: true,
                group: {
                    PptPl1Spl: 15,
                    PptPl2Sppt: 25,
                    PptPl3Fppt: 35,
                },
            ),
            Balanced: (
                enabled: true,
                group: {
                    PptPl1Spl: 40,
                    PptPl2Sppt: 25,
                    PptPl3Fppt: 35,
                },
            ),
            Performance: (
                enabled: true,
                group: {
                    PptPl1Spl: 80,
                    PptPl2Sppt: 80,
                    PptPl3Fppt: 80,
                },
            ),
        },
        dc_profile_tunings: {},
        armoury_settings: {
            NvDynamicBoost: 5,
            NvTempTarget: 75,
        },
    )
    '';
    mode = "0777";
  };

#   environment.etc."asusd/fan_curves.ron" = {
#     text = ''
#     (
#         profiles: (
#             balanced: [
#                 (
#                     fan: CPU,
#                     pwm: (12, 43, 48, 58, 68, 94, 114, 140),
#                     temp: (47, 62, 65, 68, 70, 72, 74, 76),
#                     enabled: false,
#                 ),
#                 (
#                     fan: GPU,
#                     pwm: (28, 53, 66, 76, 86, 107, 135, 160),
#                     temp: (47, 59, 62, 65, 67, 69, 71, 73),
#                     enabled: false,
#                 ),
#                 (
#                     fan: MID,
#                     pwm: (2, 51, 58, 58, 94, 130, 188, 242),
#                     temp: (47, 62, 65, 68, 70, 72, 74, 76),
#                     enabled: false,
#                 ),
#             ],
#             performance: [
#                 (
#                     fan: CPU,
#                     pwm: (43, 48, 58, 94, 114, 130, 150, 186),
#                     temp: (20, 64, 66, 68, 70, 72, 74, 76),
#                     enabled: false,
#                 ),
#                 (
#                     fan: GPU,
#                     pwm: (53, 66, 76, 107, 135, 150, 170, 209),
#                     temp: (20, 57, 60, 63, 66, 69, 72, 75),
#                     enabled: false,
#                 ),
#                 (
#                     fan: MID,
#                     pwm: (51, 58, 58, 130, 188, 198, 237, 237),
#                     temp: (20, 64, 66, 68, 70, 72, 74, 76),
#                     enabled: false,
#                 ),
#             ],
#             quiet: [
#                 (
#                     fan: CPU,
#                     pwm: (12, 28, 43, 48, 58, 68, 94, 94),
#                     temp: (43, 69, 70, 72, 74, 76, 78, 78),
#                     enabled: false,
#                 ),
#                 (
#                     fan: GPU,
#                     pwm: (28, 38, 53, 66, 76, 86, 107, 107),
#                     temp: (43, 67, 68, 70, 70, 70, 70, 70),
#                     enabled: false,
#                 ),
#                 (
#                     fan: MID,
#                     pwm: (2, 5, 51, 58, 58, 127, 130, 130),
#                     temp: (43, 69, 70, 72, 74, 76, 78, 78),
#                     enabled: false,
#                 ),
#             ],
#         ),
#     )
#     '';
#   mode = "0777";
# };

  environment.etc."asusd/slash.ron" = {
    text = ''
    (
        enabled: false,
        brightness: 0,
        display_interval: 0,
        display_mode: Bounce,
        show_on_boot: false,
        show_on_shutdown: false,
        show_on_sleep: false,
        show_on_battery: false,
        show_battery_warning: false,
    )
    '';
    mode = "0777";
  };

  environment.etc."asusd/aura_19b6.ron" = {
    text = ''
    (
        config_name: "aura_19b6.ron",
        brightness: Med,
        current_mode: Static,
        builtins: {
            Static: (
                mode: Static,
                zone: None,
                colour1: (
                    r: 0,
                    g: 8,
                    b: 8,
                ),
                colour2: (
                    r: 0,
                    g: 0,
                    b: 0,
                ),
                speed: Med,
                direction: Right,
            ),
            Breathe: (
                mode: Breathe,
                zone: None,
                colour1: (
                    r: 166,
                    g: 0,
                    b: 0,
                ),
                colour2: (
                    r: 0,
                    g: 0,
                    b: 0,
                ),
                speed: Med,
                direction: Right,
            ),
            Pulse: (
                mode: Pulse,
                zone: None,
                colour1: (
                    r: 166,
                    g: 0,
                    b: 0,
                ),
                colour2: (
                    r: 0,
                    g: 0,
                    b: 0,
                ),
                speed: Med,
                direction: Right,
            ),
        },
        multizone_on: false,
        enabled: (
            states: [
                (
                    zone: Keyboard,
                    boot: true,
                    awake: true,
                    sleep: false,
                    shutdown: false,
                ),
            ],
        ),
    )
    '';
    mode = "0777";
  };
}