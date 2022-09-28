create or replace function FIRSTPINYIN(
    P_NAME in varchar2)
return varchar2
as
V_COMPARE varchar2(100);
V_RETURN varchar2(4000);
function F_NLSSORT(P_WORD in varchar2) return varchar2 as
begin
return nlssort(P_WORD, 'NLS_SORT=SCHINESE_PINYIN_M');
end;
begin



  V_COMPARE := F_NLSSORT(substr(NVL(P_NAME,0), 0, 1));
  if V_COMPARE >= F_NLSSORT(' 吖 ') and V_COMPARE <= F_NLSSORT('驁 ') then
  V_RETURN := V_RETURN || 'a';
  elsif V_COMPARE >= F_NLSSORT('八 ') and V_COMPARE <= F_NLSSORT('簿 ') then
  V_RETURN := V_RETURN || 'b';
  elsif V_COMPARE >= F_NLSSORT('嚓 ') and V_COMPARE <= F_NLSSORT('錯 ') then
  V_RETURN := V_RETURN || 'c';
  elsif V_COMPARE >= F_NLSSORT('咑 ') and V_COMPARE <= F_NLSSORT('鵽 ') then
  V_RETURN := V_RETURN || 'd';
  elsif V_COMPARE >= F_NLSSORT('妸 ') and V_COMPARE <= F_NLSSORT('樲 ') then
  V_RETURN := V_RETURN || 'e';
  elsif V_COMPARE >= F_NLSSORT('发 ') and V_COMPARE <= F_NLSSORT('猤 ') then
  V_RETURN := V_RETURN || 'f';
  elsif V_COMPARE >= F_NLSSORT('旮 ') and V_COMPARE <= F_NLSSORT('腂 ') then
  V_RETURN := V_RETURN || 'g';
  elsif V_COMPARE >= F_NLSSORT('妎 ') and V_COMPARE <= F_NLSSORT('夻 ') then
  V_RETURN := V_RETURN || 'h';
  elsif V_COMPARE >= F_NLSSORT('丌 ') and V_COMPARE <= F_NLSSORT('攈 ') then
  V_RETURN := V_RETURN || 'j';
  elsif V_COMPARE >= F_NLSSORT('咔 ') and V_COMPARE <= F_NLSSORT('穒 ') then
  V_RETURN := V_RETURN || 'k';
  elsif V_COMPARE >= F_NLSSORT('垃 ') and V_COMPARE <= F_NLSSORT('擽 ') then
  V_RETURN := V_RETURN || 'l';
  elsif V_COMPARE >= F_NLSSORT('嘸 ') and V_COMPARE <= F_NLSSORT('椧 ') then
  V_RETURN := V_RETURN || 'm';
  elsif V_COMPARE >= F_NLSSORT('拏 ') and V_COMPARE <= F_NLSSORT('瘧 ') then
  V_RETURN := V_RETURN || 'n';
  elsif V_COMPARE >= F_NLSSORT('筽 ') and V_COMPARE <= F_NLSSORT('漚 ') then
  V_RETURN := V_RETURN || 'o';
  elsif V_COMPARE >= F_NLSSORT('妑 ') and V_COMPARE <= F_NLSSORT('曝 ') then
  V_RETURN := V_RETURN || 'p';
  elsif V_COMPARE >= F_NLSSORT('七 ') and V_COMPARE <= F_NLSSORT('裠 ') then
  V_RETURN := V_RETURN || 'q';
  elsif V_COMPARE >= F_NLSSORT('亽 ') and V_COMPARE <= F_NLSSORT('鶸 ') then
  V_RETURN := V_RETURN || 'r';
  elsif V_COMPARE >= F_NLSSORT('仨 ') and V_COMPARE <= F_NLSSORT('蜶 ') then
  V_RETURN := V_RETURN || 's';
  elsif V_COMPARE >= F_NLSSORT('侤 ') and V_COMPARE <= F_NLSSORT('籜 ') then
  V_RETURN := V_RETURN || 't';
  elsif V_COMPARE >= F_NLSSORT('屲 ') and V_COMPARE <= F_NLSSORT('鶩 ') then
  V_RETURN := V_RETURN || 'w';
  elsif V_COMPARE >= F_NLSSORT('夕 ') and V_COMPARE <= F_NLSSORT('鑂 ') then
  V_RETURN := V_RETURN || 'x';
  elsif V_COMPARE >= F_NLSSORT('丫 ') and V_COMPARE <= F_NLSSORT('韻 ') then
  V_RETURN := V_RETURN || 'y';
  elsif V_COMPARE >= F_NLSSORT('帀 ') and V_COMPARE <= F_NLSSORT('咗 ') then
  V_RETURN := V_RETURN || 'z';
  else
    V_RETURN := V_RETURN ||substr(P_NAME, 0, 1);
end if;


return V_RETURN;

end;
