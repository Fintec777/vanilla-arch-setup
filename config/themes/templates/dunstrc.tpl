[global]
    monitor              = 0
    follow               = mouse
    width                = 380
    height               = 120
    origin               = top-right
    offset               = 10x36
    gap_size             = 6
    padding              = 12
    horizontal_padding   = 14
    frame_width          = 2
    frame_color          = "{{ accent }}"
    sort                 = yes
    font                 = JetBrains Mono 11
    markup               = full
    format               = "<b>%s</b>\n%b"
    alignment            = left
    vertical_alignment   = center
    show_age_threshold   = 60
    word_wrap            = yes
    ellipsize            = middle
    stack_duplicates     = true
    hide_duplicate_count = false
    show_indicators      = yes
    icon_position        = left
    min_icon_size        = 0
    max_icon_size        = 32
    icon_theme           = Papirus-Dark, Adwaita
    enable_recursive_icon_lookup = true
    sticky_history       = yes
    history_length       = 20
    browser              = xdg-open
    always_run_script    = true
    corner_radius        = 8
    mouse_left_click     = close_current
    mouse_middle_click   = do_action, close_current
    mouse_right_click    = close_all

[urgency_low]
    background  = "{{ background }}"
    foreground  = "{{ foreground }}"
    frame_color = "{{ color0 }}"
    timeout     = 4

[urgency_normal]
    background  = "{{ background }}"
    foreground  = "{{ foreground }}"
    frame_color = "{{ accent }}"
    timeout     = 8

[urgency_critical]
    background  = "{{ background }}"
    foreground  = "{{ color1 }}"
    frame_color = "{{ color1 }}"
    timeout     = 0
