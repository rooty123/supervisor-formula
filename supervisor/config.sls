# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "supervisor/map.jinja" import supervisor with context %}

{% if 'programs' in supervisor -%}
{% for program,values in supervisor.programs.items() -%}
supervisor-program-{{ program }}:
  file.managed:
    - name: {{ supervisor.program_dir }}/{{ program }}-prog.conf
    - source: salt://supervisor/templates/program.conf.tmpl
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - defaults:
        program: {{ program }}
        values: {{ values }}
    - watch_in:
      - service: supervisor.service
{% endfor -%}
{% endif -%}
