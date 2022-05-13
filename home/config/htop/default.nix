{ config, lib, pkgs, ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      delay = 15;
      header_margin = 1;
      show_program_path = 0;
      shadow_other_users = 0;
      tree_sort_key = 47;
      tree_sort_direction = -1;
      show_merged_command = 1;
      find_comm_in_cmdline = 1;
      strip_exe_from_cmdline = 1;
      tree_view = 1;
      all_branches_collapsed = 1;
      update_process_names = 1;
      enable_mouse = 1;
      show_cpu_usage = 1;
      highlight_threads = 1;
      hide_kernel_threads = 0;
      hide_userland_threads = 0;
      highlight_megabytes = 1;
      highlight_base_name = 1;

      fields = with config.lib.htop.fields; [
        PID
        USER
        STATE
        PRIORITY
        NICE
        M_SIZE # M_VIRT
        M_RESIDENT
        M_SHARE
        PERCENT_CPU
        PERCENT_MEM
        TIME
        #ELAPSED
        COMM
      ];
    } // (with config.lib.htop;
      leftMeters [
        (bar "AllCPUs")
        (bar "CPU")
        (text "Blank")
        (text "Memory")
        (text "Swap")
      ]) // (with config.lib.htop;
        rightMeters [
          (text "Systemd")
          (text "Tasks")
          (text "LoadAverage")
          (text "Uptime")
          (text "Blank")
          (text "DiskIO")
          (text "NetworkIO")
        ]);
  };
}
