begin;

  alter table testcases add column explained bool not null default false;

rollback; -- change this to: commit;
