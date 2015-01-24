*************************************************************************
**********************************************************************************************************
*** ACTUALIZACION DE ARTICULOS (updt_arts_sol)
**********************************************************************************************************
*** Se alimenta de la base de datos ART_A cada hora para actualizar costos y precios demas datos de articulos.
*** Actualiza las empresas SOLP_A y SOL_A asegurando la siguiente premisa
*** ART_A.ART.COS_MERC > EMPRESAXXX.ART.ULT_COS_UN 
**********************************************************************************************************
*** Roy Enero 2015
**********************************************************************************************************

tconnect = SQLCONECTAR()
tconnect1 = SQLCONECTAR()
tconnect2 = SQLCONECTAR()
tconnect3 = SQLCONECTAR()

*Roy: Getting and formating date and time
*NOTE: string >> fechaHora && datetime >> convert(datetime,fechaHora,131)
fechaHoy=date()
horaHoy=time()
fechaHora=DATETIME(YEAR(fechaHoy), MONTH(fechaHoy), DAY(fechaHoy), VAL(LEFT(horaHoy, 2)), VAL(SUBS(horaHoy, 4, 2)), VAL(RIGHT(horaHoy, 2)))

If  mensaje_sql(tconnect,0) <= 0
	Return .F.
Endif
If  mensaje_sql(tconnect1,0) <= 0
	Return .F.
Endif

MESSAGEBOX(":.:Proceso Actualizacion De Precios :.: "+Chr(13)+"-->  INICIADO <--" +Chr(13)+"Este proceso puede tomar al rededor de un minuto.",64,"::Dpto Informatica :) Compresores Servicios::")

*************************************************************************
*INSERT DE LINEA*
*************************************************************************
tresult=sqlexec(tconnect,'select * from ART_A.dbo.lin_art','v_linea')

do while !EOF('v_linea')
	*SOL_A
		tresult1=sqlexec(tconnect1,'select * from SOL_A.dbo.lin_art where co_lin=?v_linea.co_lin','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOL_A: SE INSERTO UNA NUEVA LINEA: "+Chr(13)+ v_linea.co_lin)
			ins="INSERT INTO [SOL_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOL_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF
	

	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.lin_art where co_lin=?v_linea.co_lin','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOLP_A: SE INSERTO UNA NUEVA LINEA: "+Chr(13)+ v_linea.co_lin)
			ins="INSERT INTO [SOLP_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOLP_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF
	
skip in v_linea
enddo



*************************************************************************
*INSERT DE SUBLINEA*
*************************************************************************
tresult=sqlexec(tconnect,'select * from ART_A.dbo.sub_lin','v_sublinea')

do while !EOF('v_sublinea')
	*SOL_A
		tresult1=sqlexec(tconnect1,'select * from SOL_A.dbo.sub_lin where co_subl=?v_sublinea.co_subl','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOL_A: SE INSERTO UNA NUEVA SUBLINEA: "+Chr(13)+ v_sublinea.co_subl)
			ins="INSERT INTO [SOL_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOL_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF
	
	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.sub_lin where co_subl=?v_sublinea.co_subl','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOLP_A: SE INSERTO UNA NUEVA SUBLINEA: "+Chr(13)+ v_sublinea.co_subl)
			ins="INSERT INTO [SOLP_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOLP_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF

skip in v_sublinea
enddo



*************************************************************************
*INSERT DE CATEGORIA*
*************************************************************************
tresult=sqlexec(tconnect,'select * from ART_A.dbo.cat_art','v_cat')


do while !EOF('v_cat')
	*SOL_A
		tresult1=sqlexec(tconnect1,'select * from SOL_A.dbo.cat_art where co_cat=?v_cat.co_cat','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOL_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [SOL_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOL_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.cat_art where co_cat=?v_cat.co_cat','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOLP_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [SOLP_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOLP_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF


skip in v_cat
enddo

*************************************************************************
*INSERT DE ARTICULOS*
*************************************************************************
con=0
conCOSEP=0


tresult=sqlexec(tconnect,'select * from ART_A.dbo.art','v_SC')

do while !EOF('v_SC')	

	*SOL_A
		tresult1=sqlexec(tconnect1,'select * from SOL_A.dbo.art where co_art=?v_SC.co_art','v_resultado')
		if EOF('v_resultado')
			
			ins="INSERT INTO [SOL_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1, campo2, campo8)"+;
			" VALUES (?v_SC.co_art,?v_SC.art_des,?v_SC.co_lin,?v_SC.co_cat,?v_SC.co_subl,?v_SC.co_color,?v_SC.procedenci,"+;
			"'0000000001',?v_SC.uni_venta,?v_SC.suni_venta,?v_SC.tipo,?v_SC.tipo_imp,?v_SC.comentario,?v_SC.porc_cos,?v_SC.cos_merc,"+;
			"?v_SC.prec_vta1, ?v_SC.prec_vta2, ?v_SC.prec_vta3, ?v_SC.prec_vta4, ?v_SC.prec_vta5, ?v_SC.dis_cen, ?v_SC.tipo_cos, ?v_SC.campo1, ?v_SC.campo2, ?fechaHora )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"SOL_A Error sql Insertando ART 1, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_SC.co_art)
			   Return .F.
			else
				con=con+1
				*MESSAGEBOX("SOL_A: SE INSERTO UN NUEVO ARTICULO: " + v_SC.co_art)	
			ENDIF
		ENDIF


	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.art where co_art=?v_SC.co_art','v_resultado')
		if EOF('v_resultado')
			
			ins="INSERT INTO [SOLP_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1, campo2, campo8)"+;
			" VALUES (?v_SC.co_art,?v_SC.art_des,?v_SC.co_lin,?v_SC.co_cat,?v_SC.co_subl,?v_SC.co_color,?v_SC.procedenci,"+;
			"'0000000001',?v_SC.uni_venta,?v_SC.suni_venta,?v_SC.tipo,?v_SC.tipo_imp,?v_SC.comentario,?v_SC.porc_cos,?v_SC.cos_merc,"+;
			"?v_SC.prec_vta1, ?v_SC.prec_vta2, ?v_SC.prec_vta3, ?v_SC.prec_vta4, ?v_SC.prec_vta5, ?v_SC.dis_cen, ?v_SC.tipo_cos, ?v_SC.campo1, ?v_SC.campo2, ?fechaHora )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Empresa: SOLP_A Error sql Insertando ART, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_SC.co_art)
			   Return .F.
			else
				conCOSEP=conCOSEP+1
				*MESSAGEBOX("SOLP_A: SE INSERTO UN NUEVO ARTICULO: " + v_SC.co_art)	
			ENDIF
		ENDIF

skip in v_SC
enddo


InsertResultString="Se han insertado la siguiente cantidad de articulos en las empresas."+Chr(13)+Chr(13)+"SOL_A: "+ALLTRIM(STR(con))+Chr(13)+"SOLP_A: "+ALLTRIM(STR(conCOSEP))
Messagebox(InsertResultString,64,"Insercion de Articulos Nuevos")

*************************************************************************
*ACTUALIZACION DE ARTICULOS*
*************************************************************************
*La actualizacion para SOLP_A se hace quitando el IVA y tomando en cuenta que el prec_vta3>0 y ART_A.stock_act>0
*La actualizacion para SOL_A se hace siempre y cuando el cos_merc de ART_A > SOL_A y ART_A.stock_act>0

*SOL_A
	act="update [SOL_A].[DBO].[ART] set art_des=ART_A.art_des, comentario=ART_A.comentario, porc_cos=ART_A.porc_cos, "+;
	"prec_vta1=ART_A.prec_vta1, prec_vta2=ART_A.prec_vta2, prec_vta3=ART_A.prec_vta3, prec_vta4=ART_A.prec_vta4, prec_vta5=ART_A.prec_vta5, "+;
	"fec_prec_v=ART_A.fec_prec_v, fec_prec_2=ART_A.fec_prec_2, fec_prec_3=ART_A.fec_prec_3, fec_prec_4=ART_A.fec_prec_4, fec_prec_5=convert(smalldatetime,?fechaHoy,101), campo8=?fechaHora, " +; 
	"fec_cos_p2=ART_A.fec_cos_p2, cos_merc=ART_A.cos_merc, fec_cos_me=ART_A.fec_cos_me, tipo_cos=ART_A.tipo_cos, dis_cen=ART_A.dis_cen, campo1=ART_A.campo1, campo2=ART_A.campo2 "+;
	"FROM ART_A.dbo.art "+; 
	"AS ART_A inner join SOL_A.dbo.art as SOL_A on ART_A.co_art=SOL_A.co_art " +;
	"WHERE ART_A.stock_act> 0 AND (ART_A.cos_merc > SOL_A.cos_merc)"

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en SOL_A!") <= 0
		Return .F.
	ENDIF

	act="update [SOL_A].[DBO].[ART] set art_des=ART_A.art_des, comentario=ART_A.comentario, "+;
	"campo1=ART_A.campo1, campo2=ART_A.campo2 "+;
	"FROM ART_A.dbo.art "+; 
	"AS ART_A inner join SOL_A.dbo.art as SOL_A on ART_A.co_art=SOL_A.co_art "

	tresult4=sqlexec(tconnect4,act)
	If mensaje_sql(tresult4,1,"Error UPDATE descriptions en SOL_A!") <= 0
		Return .F.
	ENDIF

*SOLP_A
	act="update [SOLP_A].[DBO].[ART] set art_des=ART_A.art_des, comentario=ART_A.comentario, porc_cos=((( (ART_A.prec_vta3/'1.2544')-ART_A.cos_merc)/(ART_A.prec_vta3/'1.2544'))*100 -1), "+;
	"prec_vta1=ART_A.prec_vta1/'1.12', prec_vta2=ART_A.prec_vta2/'1.12', prec_vta3=ART_A.prec_vta3/'1.12', prec_vta4=ART_A.prec_vta4/'1.12', prec_vta5=ART_A.prec_vta5/'1.12', "+;
	"fec_prec_v=ART_A.fec_prec_v, fec_prec_2=ART_A.fec_prec_2, fec_prec_3=ART_A.fec_prec_3, fec_prec_4=ART_A.fec_prec_4, fec_prec_5=convert(smalldatetime,?fechaHoy,101), campo8=?fechaHora,  " +; 
	"fec_cos_p2=ART_A.fec_cos_p2, cos_merc=ART_A.cos_merc, fec_cos_me=ART_A.fec_cos_me, tipo_cos=ART_A.tipo_cos, dis_cen=ART_A.dis_cen, campo1=ART_A.campo1, campo2=ART_A.campo2 "+;
	"FROM ART_A.dbo.art "+; 
	"AS ART_A inner join SOLP_A.dbo.art as SOLP_A on ART_A.co_art=SOLP_A.co_art " +;
	"WHERE ART_A.prec_vta3>0"

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en SOLP_A!") <= 0
		Return .F.
	ENDIF

	act="update [SOLP_A].[DBO].[ART] set art_des=ART_A.art_des, comentario=ART_A.comentario, "+;
	"campo1=ART_A.campo1, campo2=ART_A.campo2 "+;
	"FROM ART_A.dbo.art "+; 
	"AS ART_A inner join SOLP_A.dbo.art as SOLP_A on ART_A.co_art=SOLP_A.co_art "

	tresult4=sqlexec(tconnect4,act)
	If mensaje_sql(tresult4,1,"Error UPDATE descriptions en SOLP_A!") <= 0
		Return .F.
	ENDIF


MESSAGEBOX(":.:Proceso Actualizacion De Precios :.: "+Chr(13)+"--> Completado Exitosamente <--" +Chr(13)+"Recuerde actualizar las Tablas locales en las empresas actualizadas.",64,"::Dpto Informatica :) Compresores Servicios::")


*ACTUALIZADO EL 26-05-2014
*ACTUALIZA TARIBA LLEVANDO TODOS LOS DATOS DE LOS ARTICULOS DE BARRIO OBRERO...
*ACTUALIZA SOLP_A = QUE TARIBA PERO LE QUITA EL IVA A LOS PRECIOS Y POR SUPUESTO AL MARGEN MINIMO...
*USA CAMPOS 7 Y 8 PARA GUARDAR LA FECHA Y LA HORA DE ACTUALIZACION... TANTO EN SOLP_A COMO EN TARIBA
*LOS ARTICULOS QUE NO TIENEN PRECIOS... NO SE ACTUALIZAN DE NINGUNA FORMA... POR ELLO PUEDE HABER ARTICULOS QUE NO TENGAN LA FECHA DE ACTUALIZACION...
*************************************************************************
*** ACTUALIZADO EL 15-01-15 		*
*** ACTUALIZA: SOL_A, SOLP_A, SOLP_A, CONAI_A				*
*** EL PROCESO CAMBIO DEBIDO A QUE SOL_A Y CONAI_A HACEN COMPRAS ENTONCES	*
*** ESTA ACTUALIZACION DE DATA SE HACE UNICAMENTE CUANDO  U *
*** ART_A.ART.COS_MERC > EMPRESAXXX.ART.ULT_COS_UN *
*** YA QUE SIEMPRE SE DEBEN MANTENER LOS PRECIOS/COSTOS MAS ALTOS *
*************************************************************************
*** Actualizado 18-01-15
*** Se alimenta de la base de datos ART_A cada hora para actualizar costos y precios demas datos de articulos.
*** Actualiza las empresas SOLP_A y SOL_A
*** Y otro que lo ejecutara Duvin. (muy parecido al que corria JeanCarlos)
*** Aqui se setean las horas en las cuales el proceso se ejecuto por Wender... esta informacion se repartira a las demas empresas para referencias... 
*** LA CONDICION DE PREC_VTA3 en el update NO ES NECESARIA LOGICAMENTE PERO ESTA PARA EVITAR ERRORES DEL PERSONAL DE COSERVICA
*** Si hay cambios en las descripciones las mismas no se haran sino se cambia un costo y se cumpla la condicion de que el costo sea mayor
*************************************************************************