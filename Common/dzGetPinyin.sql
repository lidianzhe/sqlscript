if object_id('dzGetPinyin') is null
	exec ('create   function  dzGetPinyin(@i int) returns int as begin return 1 end')     
   
go
alter   function   [dbo].[dzGetPinyin](@Str   varchar(500)='')  
returns   varchar(500) 
with encryption     
as     
begin     
declare   @strlen   int,@return   varchar(500),@ii   int     
declare   @n   int,@c   nchar(1),@chn   nchar(1)     
     
select   @strlen=len(@str),@return='',@ii=0     
set   @ii=0     
while   @ii<@strlen     
begin     
	select   @ii=@ii+1,@n=95,@chn=substring(@str,@ii,1) 
	if @chn in ('£±','£²','£³','£´','£µ','£¶','£·','£¸','£¹','£°')
	begin
		select @c=pinyin
		from(select chn='£±',pinyin='1'
				union all select chn='£²',pinyin='2'
				union all select chn='£³',pinyin='3'
				union all select chn='£´',pinyin='4'
				union all select chn='£µ',pinyin='5'
				union all select chn='£¶',pinyin='6'
				union all select chn='£·',pinyin='7'
				union all select chn='£¸',pinyin='8'
				union all select chn='£¹',pinyin='9'
				union all select chn='£°',pinyin='0'				
			) as a
		where chn=@chn
	end
	else
	begin    
		select   @n   =   @n   +1     
			,@c   =   case   chn   when   @chn   then   char(@n)   else   @c   end     
		from(     
			select   top   27   *   from   (     
			select   chn   =   'ß¹'     
			union   all   select   '°Ë'     
			union   all   select   'àê'     
			union   all   select   '…ö'     
			union   all   select   'ŠŠ'     
			union   all   select   '·¢'     
			union   all   select   'ê¸'     
			union   all   select   'îþ'     
			union   all   select   'Ø¢' --'i'     
			union   all   select   'Ø¢'     
			union   all   select   'ßÇ'     
			union   all   select   'À¬'     
			union   all   select   '‡`'     
			union   all   select   '’‚'     
			union   all   select   'àÞ'     
			union   all   select   'Šr'     
			union   all   select   'Æß'     
			union   all   select   '…ß'     
			union   all   select   'Øí'     
			union   all   select   'Ëû'     
			union   all   select   'ŒÜ' --'u'     
			union   all   select   'ŒÜ' --'v'     
			union   all   select   'ŒÜ'     
			union   all   select   'Ï¦'     
			union   all   select   'Ñ¾'     
			union   all   select   'Ž‰'     
			union   all   select   @chn)   as   a     
		order   by   chn   COLLATE   Chinese_PRC_CI_AS       
		)   as   b     
 
		if ascii(@c)<=96 
 			set @c=@chn
 	end

	set  @return=@return+@c     
end     

return(@return)     
end  
 
