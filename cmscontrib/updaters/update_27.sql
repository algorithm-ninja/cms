begin;

  alter table submissions add column official not null bool default true;
  alter table contests add column analysis_enabled boolean not null default false;
  alter table contests add column analysis_start timestamp without time zone;
  alter table contests add column analysis_stop timestamp without time zone;
  update contests set analysis_start = stop;
  update contests set analysis_stop = stop;

rollback; -- change this to: commit;
