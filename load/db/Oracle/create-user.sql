--
-- sqlplus -S system/iAmSystem@ora18 @create-user
--
drop user st_zh cascade;

create user st_zh
   identified by st_zh
   default tablespace data
   quota unlimited on data;

grant
   connect,
   create table
to
   st_zh;

exit
