**********************************************************************************************************
**********************************************************************************************************
*** ACTUALIZACION DE ARTICULOS EL SOL (updt_arts_sol)
**********************************************************************************************************
*** Se alimenta de la base de datos ART_A cada hora para actualizar costos precios y demas datos de articulos.
*** Actualiza las empresas SOLP_A y SOL_A basado en la siguiente premisa
*** ART_A.ART.COS_MERC > EMPRESAXXX.ART.ULT_COS_UN 
*** En caso negativo genera un reporte para posterior analisis.
**********************************************************************************************************
**********************************************************************************************************
*** Ultima actualizacion... Roy Febrero 2016
**********************************************************************************************************

tconnect = SQLCONECTAR()
tconnect1 = SQLCONECTAR()
tconnect2 = SQLCONECTAR()
tconnect3 = SQLCONECTAR()
tconnect4 = SQLCONECTAR()


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
*INSERT DE COLOR*
*************************************************************************

tresult=sqlexec(tconnect,'select * from ART_A.dbo.colores','v_color')

do while !EOF('v_color')
	*SOL_A
		tresult1=sqlexec(tconnect1,'select * from SOL_A.dbo.colores where co_col=?v_color.co_col','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOL_A: SE INSERTO UN NUEVO COLOR:" + v_color.co_col)
			ins="INSERT INTO [SOL_A].[dbo].[colores] (co_col,des_col) VALUES (?v_color.co_col,?v_color.des_col)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error: 1, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.colores where co_col=?v_color.co_col','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOLP_A: SE INSERTO UN NUEVO COLOR:" + v_color.co_col)
			ins="INSERT INTO [SOLP_A].[dbo].[colores] (co_col,des_col) VALUES (?v_color.co_col,?v_color.des_col)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error: 2, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF
skip in v_color
enddo

*************************************************************************
*INSERT DE LINEA*
*************************************************************************
tresult=sqlexec(tconnect,'SELECT * FROM ART_A.dbo.lin_art','v_linea')

do while !EOF('v_linea')
	*SOL_A
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOL_A.dbo.lin_art WHERE co_lin=?v_linea.co_lin','v_RS')
		if EOF('v_RS')
			MESSAGEBOX("SOL_A: SE INSERTO UNA NUEVA LINEA: "+Chr(13)+ v_linea.co_lin)
			ins="INSERT INTO [SOL_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error: 3, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
			   Return .F.
			ENDIF
		ENDIF
	

	*SOLP_A
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOLP_A.dbo.lin_art WHERE co_lin=?v_linea.co_lin','v_RS')
		if EOF('v_RS')
			MESSAGEBOX("SOLP_A: SE INSERTO UNA NUEVA LINEA: "+Chr(13)+ v_linea.co_lin)
			ins="INSERT INTO [SOLP_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error: 4, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
			   Return .F.
			ENDIF
		ENDIF
	
skip in v_linea
enddo



*************************************************************************
*INSERT DE SUBLINEA*
*************************************************************************
tresult=sqlexec(tconnect,'SELECT * FROM ART_A.dbo.sub_lin','v_sublinea')

do while !EOF('v_sublinea')
	*SOL_A
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOL_A.dbo.sub_lin WHERE co_subl=?v_sublinea.co_subl','v_RS')
		if EOF('v_RS')
			MESSAGEBOX("SOL_A: SE INSERTO UNA NUEVA SUBLINEA: "+Chr(13)+ v_sublinea.co_subl)
			ins="INSERT INTO [SOL_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error: 5, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
			 Return .F.
			ENDIF
		ENDIF
	
	*SOLP_A
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOLP_A.dbo.sub_lin WHERE co_subl=?v_sublinea.co_subl','v_RS')
		if EOF('v_RS')
			MESSAGEBOX("SOLP_A: SE INSERTO UNA NUEVA SUBLINEA: "+Chr(13)+ v_sublinea.co_subl)
			ins="INSERT INTO [SOLP_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error: 6, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
			 Return .F.
			ENDIF
		ENDIF

skip in v_sublinea
enddo



*************************************************************************
*INSERT DE CATEGORIA*
*************************************************************************
tresult=sqlexec(tconnect,'SELECT * FROM ART_A.dbo.cat_art','v_cat')


do while !EOF('v_cat')
	*SOL_A
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOL_A.dbo.cat_art WHERE co_cat=?v_cat.co_cat','v_RS')
		if EOF('v_RS')
			MESSAGEBOX("SOL_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [SOL_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error: 7, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
			  Return .F.
			ENDIF
		ENDIF

	*SOLP_A
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOLP_A.dbo.cat_art WHERE co_cat=?v_cat.co_cat','v_RS')
		if EOF('v_RS')
			MESSAGEBOX("SOLP_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [SOLP_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error: 8, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
			  Return .F.
			ENDIF
		ENDIF


skip in v_cat
enddo

*************************************************************************
*INSERT / UPDATE DE ARTICULOS*
*************************************************************************
*********
***SOL***
*********
new_SOL=0
new_SOLP=0
updated_SOL=0
updated_SOLP=0
reported_code0=0
reported_code1=0
reported_code2=0
conArt=0

* UPDATING ONLY Those with STOCK on CS
tresult=sqlexec(tconnect,'SELECT * FROM ART_A.dbo.art WHERE stock_act>0','v_CS')

do while !EOF('v_CS')
	conArt=conArt+1
	*SOL_A* PASO 1: GUARDAR NUEVO	
	tresult1=sqlexec(tconnect1,'SELECT * FROM SOL_A.dbo.art WHERE co_art=?v_CS.co_art','v_RS')
	*IF EXISTS
	if EOF('v_RS')
		ins="INSERT INTO [SOL_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
		" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1, campo2, campo8)"+;
		" VALUES (?v_CS.co_art,?v_CS.art_des,?v_CS.co_lin,?v_CS.co_cat,?v_CS.co_subl,?v_CS.co_color,?v_CS.procedenci,"+;
		"'0000000001',?v_CS.uni_venta,?v_CS.suni_venta,?v_CS.tipo,?v_CS.tipo_imp,?v_CS.comentario,?v_CS.porc_cos,?v_CS.cos_merc,"+;
		"?v_CS.prec_vta1, ?v_CS.prec_vta2, ?v_CS.prec_vta3, ?v_CS.prec_vta4, ?v_CS.prec_vta5, ?v_CS.dis_cen, ?v_CS.tipo_cos, ?v_CS.campo1, ?v_CS.campo2, ?v_CS.campo8 )"

		tresult2=sqlexec(tconnect2,ins)
		If mensaje_sql(tresult2,1,"Error: 9, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
			messagebox(v_CS.co_art)
		   Return .F.
		else
			new_SOL=new_SOL+1
			*MESSAGEBOX("SOL_A: SE INSERTO UN NUEVO ARTICULO: " + v_CS.co_art)	
		ENDIF
	ELSE
		*SOL_A* PASO 2: ACTUALIZAR O INFORMAR
		IF (v_CS.cos_merc > v_RS.cos_merc)
			**2.1 UPDATE RS=CS**
			costUpdate_query="UPDATE [SOL_A].[DBO].[ART] SET porc_cos=ART_A.porc_cos, cos_merc=ART_A.cos_merc, fec_cos_me=ART_A.fec_cos_me, tipo_cos=ART_A.tipo_cos, "+;
			"prec_vta1=ART_A.prec_vta1, prec_vta2=ART_A.prec_vta2, prec_vta3=ART_A.prec_vta3, prec_vta4=ART_A.prec_vta4, prec_vta5=ART_A.prec_vta5, "+;
			"fec_prec_v=ART_A.fec_prec_v, fec_prec_2=ART_A.fec_prec_2, fec_prec_3=ART_A.fec_prec_3, fec_prec_4=ART_A.fec_prec_4, fec_prec_5=convert(smalldatetime,?fechaHoy,101) " +; 
			"FROM ART_A.dbo.art AS ART_A inner join SOL_A.dbo.art as SOL_A on ART_A.co_art=SOL_A.co_art " +;
			"WHERE SOL_A.co_art=?v_RS.co_art"

			tresult3=sqlexec(tconnect3,costUpdate_query)
			If mensaje_sql(tresult3,1,"Error: 10, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
				messagebox(v_CS.co_art)
				*DEBUG
				InsertResultString="Articulos creados:"+Chr(13)+Chr(13)+"SOL_A: "+ALLTRIM(STR(new_SOL))+Chr(13)+"SOLP_A: "+ALLTRIM(STR(new_SOLP))+Chr(13)+Chr(13)+"Precios Actualizados:"+Chr(13)+"SOL_A: "+ALLTRIM(STR(updated_SOL))+Chr(13)+"SOLP_A: "+ALLTRIM(STR(updated_SOLP))+Chr(13)+Chr(13)+"Articulos no actualizados a reportar HOY:"+Chr(13)+"CODIGO_1: "+ALLTRIM(STR(reported_code1))+Chr(13)+"CODIGO_2: "+ALLTRIM(STR(reported_code2))
				Messagebox(InsertResultString,64,"Resumen Proceso Actualizacion Precios")
				*DEBUG
				Return .F.
			else
				*Saving LOG
				updated_SOL=updated_SOL+1
				updatedItems="INSERT INTO [SOL_A].[dbo].[aAa_updt_log](CO_ART, ART_DES, rs_stock_act, cs_stock_act, rs_cos_merc, cs_cos_merc, rs_ult_cos_un, cs_ult_cos_un, rs_prec_vta3, cs_prec_vta3, fecha_reg)"+;
				" VALUES (?v_CS.co_art, ?v_CS.art_des, ?v_RS.stock_act, ?v_CS.stock_act, ?v_RS.cos_merc, ?v_CS.cos_merc, ?v_RS.ULT_COS_UN, ?v_CS.ULT_COS_UN, ?v_RS.prec_vta3, ?v_CS.prec_vta3, convert(smalldatetime,?fechaHora,101)) "
				Code1result=sqlexec(tconnect2,updatedItems)
				If mensaje_sql(Code1result,1,"Error: 11, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
					messagebox(v_CS.co_art)
					Return .F.
					ENDIF
			ENDIF

			**Updating Descriptions annd DATES for their analysis **
			act="UPDATE [SOL_A].[DBO].[ART] SET art_des=ART_A.art_des, comentario=ART_A.comentario, "+;
			"campo1=ART_A.campo1, campo2=ART_A.campo2, campo7=?fechaHora, campo8=ART_A.campo8 "+;
			"FROM ART_A.dbo.art AS ART_A inner join SOL_A.dbo.art as SOL_A on ART_A.co_art=SOL_A.co_art "

			tresult4=sqlexec(tconnect4,act)
			If mensaje_sql(tresult4,1,"Error: 12, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
				messagebox(v_CS.co_art)
				Return .F.
			ENDIF
		ENDIF

		IF (v_CS.cos_merc < v_RS.cos_merc)
			**2.2 INFORMING PEOPLE**
			DO CASE
			CASE (v_RS.cos_merc < v_RS.ULT_COS_UN)
				**report_code =0**
				ins="INSERT INTO [SOL_A].[dbo].[aAa_updt_reports](CO_ART,ART_DES,report_code, rs_stock_act, cs_stock_act, rs_cos_merc, cs_cos_merc, rs_ult_cos_un, cs_ult_cos_un, fecha_reg)"+;
				" VALUES (?v_CS.co_art,?v_CS.art_des,'0', ?v_RS.stock_act, ?v_CS.stock_act, ?v_RS.cos_merc, ?v_CS.cos_merc, ?v_RS.ULT_COS_UN, ?v_CS.ULT_COS_UN, convert(smalldatetime,?fechaHora,101)) "
				Code1result=sqlexec(tconnect2,ins)
				If mensaje_sql(Code1result,1,"Error: 13, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
					messagebox(v_CS.co_art)
				   Return .F.
				else
					reported_code0=reported_code0+1					
					ENDIF
			CASE (v_RS.cos_merc = v_RS.ULT_COS_UN)
				**report_code =1**
				ins="INSERT INTO [SOL_A].[dbo].[aAa_updt_reports](CO_ART,ART_DES,report_code, rs_stock_act, cs_stock_act, rs_cos_merc, cs_cos_merc, rs_ult_cos_un, cs_ult_cos_un, fecha_reg)"+;
				" VALUES (?v_CS.co_art,?v_CS.art_des,'1', ?v_RS.stock_act, ?v_CS.stock_act, ?v_RS.cos_merc, ?v_CS.cos_merc, ?v_RS.ULT_COS_UN, ?v_CS.ULT_COS_UN, convert(smalldatetime,?fechaHora,101)) "
				Code1result=sqlexec(tconnect2,ins)
				If mensaje_sql(Code1result,1,"Error: 14, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
					messagebox(v_CS.co_art)
				   Return .F.
				else
					reported_code1=reported_code1+1					
					ENDIF
			OTHERWISE
				**report_code =2**
				ins="INSERT INTO [SOL_A].[dbo].[aAa_updt_reports](CO_ART,ART_DES,report_code, rs_stock_act, cs_stock_act, rs_cos_merc, cs_cos_merc, rs_ult_cos_un, cs_ult_cos_un, fecha_reg)"+;
				" VALUES (?v_CS.co_art,?v_CS.art_des,'2', ?v_RS.stock_act, ?v_CS.stock_act, ?v_RS.cos_merc, ?v_CS.cos_merc, ?v_RS.ULT_COS_UN, ?v_CS.ULT_COS_UN, convert(smalldatetime,?fechaHora,101)) "
				Code2result=sqlexec(tconnect2,ins)
				If mensaje_sql(Code2result,1,"Error: 15, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
					messagebox(v_CS.co_art)
					*DEBUG
					InsertResultString="Articulos creados:"+Chr(13)+Chr(13)+"SOL_A: "+ALLTRIM(STR(new_SOL))+Chr(13)+"SOLP_A: "+ALLTRIM(STR(new_SOLP))+Chr(13)+Chr(13)+"Precios Actualizados:"+Chr(13)+"SOL_A: "+ALLTRIM(STR(updated_SOL))+Chr(13)+"SOLP_A: "+ALLTRIM(STR(updated_SOLP))+Chr(13)+Chr(13)+"Articulos no actualizados a reportar HOY:"+Chr(13)+"CODIGO_1: "+ALLTRIM(STR(reported_code1))+Chr(13)+"CODIGO_2: "+ALLTRIM(STR(reported_code2))
					Messagebox(InsertResultString,64,"Resumen Proceso Actualizacion Precios")
					*DEBUG
				   Return .F.
				else
					reported_code2=reported_code2+1					
					ENDIF
			ENDCASE
			ENDIF
		ENDIF

	**********
	***SOLP***
	**********
	*SOLP_A* PASO 1: GUARDAR NUEVO	
	tresult1=sqlexec(tconnect1,'SELECT * FROM SOLP_A.dbo.art WHERE co_art=?v_CS.co_art','v_RSP')
	
	*IF EXISTS
	if EOF('v_RSP')
		ins="INSERT INTO [SOLP_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
		" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1, campo2, campo8)"+;
		" VALUES (?v_CS.co_art,?v_CS.art_des,?v_CS.co_lin,?v_CS.co_cat,?v_CS.co_subl,?v_CS.co_color,?v_CS.procedenci,"+;
		"'0000000001',?v_CS.uni_venta,?v_CS.suni_venta,?v_CS.tipo,?v_CS.tipo_imp,?v_CS.comentario, ((( (?v_CS.prec_vta3/1.2544)-?v_CS.cos_merc)/(?v_CS.prec_vta3/1.2544))*100 -1) ,?v_CS.cos_merc,"+;
		"?v_CS.prec_vta1/1.12, ?v_CS.prec_vta2/1.12, ?v_CS.prec_vta3/1.12, ?v_CS.prec_vta4/1.12, ?v_CS.prec_vta5/1.12, ?v_CS.dis_cen, ?v_CS.tipo_cos, ?v_CS.campo1, ?v_CS.campo2, ?v_CS.campo8 )"

		tresult2=sqlexec(tconnect2,ins)
		If mensaje_sql(tresult2,1,"Error: 16, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
			messagebox(v_CS.co_art)
		   Return .F.
		else
			new_SOL=new_SOL+1
			ENDIF
	ELSE
		*SOLP_A* PASO 2: ACTUALIZAR
		IF (v_CS.cos_merc > v_RSP.cos_merc)
			costUpdate_query="UPDATE [SOLP_A].[DBO].[ART] SET porc_cos=ART_A.porc_cos, cos_merc=ART_A.cos_merc, fec_cos_me=ART_A.fec_cos_me, tipo_cos=ART_A.tipo_cos, "+;
			"prec_vta1=ART_A.prec_vta1, prec_vta2=ART_A.prec_vta2, prec_vta3=ART_A.prec_vta3, prec_vta4=ART_A.prec_vta4, prec_vta5=ART_A.prec_vta5, "+;
			"fec_prec_v=ART_A.fec_prec_v, fec_prec_2=ART_A.fec_prec_2, fec_prec_3=ART_A.fec_prec_3, fec_prec_4=ART_A.fec_prec_4, fec_prec_5=convert(smalldatetime,?fechaHoy,101) " +; 
			"FROM ART_A.dbo.art AS ART_A inner join SOLP_A.dbo.art as SOLP_A on ART_A.co_art=SOLP_A.co_art " +;
			"WHERE SOLP_A.co_art=?v_RSP.co_art"

			tresult3=sqlexec(tconnect3,costUpdate_query)
			If mensaje_sql(tresult3,1,"Error: 17, INFORMAR AL DPTO INFORMATICA sobre el siguiente codigo") <= 0
				messagebox(v_CS.co_art)
				Return .F.
				ENDIF
			ENDIF
		ENDIF

	skip in v_CS
	enddo

InsertResultString="De "+ALLTRIM(STR(conArt))+" Articulos con STOCK>0 en Coservica:"+Chr(13)+CHR(9)+ALLTRIM(STR(new_SOL+new_SOLP))+" Articulos creados:"+Chr(13)+CHR(9)+CHR(9)+"SOL_A: "+CHR(9)+ALLTRIM(STR(new_SOL))+Chr(13)+CHR(9)+CHR(9)+"SOLP_A: "+CHR(9)+ALLTRIM(STR(new_SOLP))+Chr(13)+Chr(13)+CHR(9)+ALLTRIM(STR(updated_SOL+updated_SOLP))+" Precios Actualizados:"+Chr(13)+CHR(9)+CHR(9)+"SOL_A: "+CHR(9)+ALLTRIM(STR(updated_SOL))+Chr(13)+CHR(9)+CHR(9)+"SOLP_A: "+CHR(9)+ALLTRIM(STR(updated_SOLP))+Chr(13)+Chr(13)+CHR(9)+ALLTRIM(STR(reported_code0+reported_code1+reported_code2))+" Articulos no actualizados a reportar HOY:"+Chr(13)+CHR(9)+CHR(9)+"CODIGO_0: "+ALLTRIM(STR(reported_code0))+Chr(13)+CHR(9)+CHR(9)+"CODIGO_1: "+ALLTRIM(STR(reported_code1))+Chr(13)+CHR(9)+CHR(9)+"CODIGO_2: "+ALLTRIM(STR(reported_code2))
Messagebox(InsertResultString,64,"Resumen Proceso Actualizacion Precios")

MESSAGEBOX(":.:Proceso Actualizacion De Precios :.: "+Chr(13)+"--> Completado Exitosamente <--" +Chr(13)+"Recuerde notificar al departamento de compras los resultados, finalmente actualizar las tablas locales en las empresas procesadas.",64,"::Dpto Informatica :) Compresores Servicios::")