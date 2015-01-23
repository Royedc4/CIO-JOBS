tconnect = SQLCONECTAR()
tconnect1 = SQLCONECTAR()
tconnect2 = SQLCONECTAR()
tconnect3 = SQLCONECTAR()
*DATE*
fechaHoy=date()
horaHoy=time()

*************************************************************************
*ACTUALIZACION*
*ABOUT*
*************************************************************************
*PROCESO CREADO POR ROYCALDERON*
*************************************************************************
*ACTUALIZADO EL 26-05-2014
*ACTUALIZA TARIBA LLEVANDO TODOS LOS DATOS DE LOS ARTICULOS DE BARRIO OBRERO...
*ACTUALIZA COSEP_A = QUE TARIBA PERO LE QUITA EL IVA A LOS PRECIOS Y POR SUPUESTO AL MARGEN MINIMO...
*USA CAMPOS 7 Y 8 PARA GUARDAR LA FECHA Y LA HORA DE ACTUALIZACION... TANTO EN COSEP_A COMO EN TARIBA
*LOS ARTICULOS QUE NO TIENEN PRECIOS... NO SE ACTUALIZAN DE NINGUNA FORMA... POR ELLO PUEDE HABER ARTICULOS QUE NO TENGAN LA FECHA DE ACTUALIZACION...
*************************************************************************
*** ACTUALIZADO EL 150115 		*
*** ACTUALIZA: SOL_A, SOLP_A, COSEP_A, CONAI_A				*
*** EL PROCESO CAMBIO DEBIDO A QUE SOL_A Y CONAI_A HACEN COMPRAS ENTONCES	*
*** ESTA ACTUALIZACION DE DATA SE HACE UNICAMENTE CUANDO  U *
*** COSER_A.ART.COS_MERC > EMPRESAXXX.ART.ULT_COS_UN *
*** YA QUE SIEMPRE SE DEBEN MANTENER LOS PRECIOS/COSTOS MAS ALTOS *
*************************************************************************



If  mensaje_sql(tconnect,0) <= 0
	Return .F.
Endif
If  mensaje_sql(tconnect1,0) <= 0
	Return .F.
Endif
MESSAGEBOX(":.:Proceso Actualizacion De Precios --> INICIADO:.:",48,"::Dpto Informatica :) Compresores Servicios::")


*************************************************************************
*INSERT DE LINEA*
*************************************************************************
tresult=sqlexec(tconnect,'select * from COSER_A.dbo.lin_art','v_linea')

do while !EOF('v_linea')
	*ART_A
		tresult1=sqlexec(tconnect1,'select * from ART_A.dbo.lin_art where co_lin=?v_linea.co_lin','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("ART_A: SE INSERTO UNA NUEVA LINEA: " + v_linea.co_lin)
			ins="INSERT INTO [ART_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN ART_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF
	

	*COSER_A
		tresult1=sqlexec(tconnect1,'select * from COSER_A.dbo.lin_art where co_lin=?v_linea.co_lin','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("COSER_A: SE INSERTO UNA NUEVA LINEA: " + v_linea.co_lin)
			ins="INSERT INTO [COSER_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN COSER_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF
	

	*SOL_A
		tresult1=sqlexec(tconnect1,'select * from SOL_A.dbo.lin_art where co_lin=?v_linea.co_lin','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOL_A: SE INSERTO UNA NUEVA LINEA: " + v_linea.co_lin)
			ins="INSERT INTO [SOL_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOL_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF
	

	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.lin_art where co_lin=?v_linea.co_lin','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOLP_A: SE INSERTO UNA NUEVA LINEA: " + v_linea.co_lin)
			ins="INSERT INTO [SOLP_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOLP_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF
	

	*CONAI_A
		tresult1=sqlexec(tconnect1,'select * from CONAI_A.dbo.lin_art where co_lin=?v_linea.co_lin','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("CONAI_A: SE INSERTO UNA NUEVA LINEA: " + v_linea.co_lin)
			ins="INSERT INTO [CONAI_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN CONAI_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF
	
skip in v_linea
enddo



*************************************************************************
*INSERT DE SUBLINEA*
*************************************************************************
tresult=sqlexec(tconnect,'select * from COSER_A.dbo.sub_lin','v_sublinea')

do while !EOF('v_sublinea')
	*ART_A
		tresult1=sqlexec(tconnect1,'select * from ART_A.dbo.sub_lin where co_subl=?v_sublinea.co_subl','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("ART_A: SE INSERTO UNA NUEVA SUBLINEA: " + v_sublinea.co_subl)
			ins="INSERT INTO [ART_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN ART_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF
	
	*COSEP_A
		tresult1=sqlexec(tconnect1,'select * from COSEP_A.dbo.sub_lin where co_subl=?v_sublinea.co_subl','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("COSEP_A: SE INSERTO UNA NUEVA SUBLINEA: " + v_sublinea.co_subl)
			ins="INSERT INTO [COSEP_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN COSEP_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF

	*SOL_A
		tresult1=sqlexec(tconnect1,'select * from SOL_A.dbo.sub_lin where co_subl=?v_sublinea.co_subl','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOL_A: SE INSERTO UNA NUEVA SUBLINEA: " + v_sublinea.co_subl)
			ins="INSERT INTO [SOL_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOL_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF

	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.sub_lin where co_subl=?v_sublinea.co_subl','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOLP_A: SE INSERTO UNA NUEVA SUBLINEA: " + v_sublinea.co_subl)
			ins="INSERT INTO [SOLP_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOLP_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF

	*CONAI_A
		tresult1=sqlexec(tconnect1,'select * from CONAI_A.dbo.sub_lin where co_subl=?v_sublinea.co_subl','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("CONAI_A: SE INSERTO UNA NUEVA SUBLINEA: " + v_sublinea.co_subl)
			ins="INSERT INTO [CONAI_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN CONAI_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF

skip in v_sublinea
enddo



*************************************************************************
*INSERT DE CATEGORIA*
*************************************************************************
tresult=sqlexec(tconnect,'select * from COSER_A.dbo.cat_art','v_cat')


do while !EOF('v_cat')
	*ART_A
		tresult1=sqlexec(tconnect1,'select * from ART_A.dbo.cat_art where co_cat=?v_cat.co_cat','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("ART_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [ART_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN ART_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

	*COSEP_A
		tresult1=sqlexec(tconnect1,'select * from COSEP_A.dbo.cat_art where co_cat=?v_cat.co_cat','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("COSEP_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [COSEP_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN COSEP_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

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

	*CONAI_A
		tresult1=sqlexec(tconnect1,'select * from CONAI_A.dbo.cat_art where co_cat=?v_cat.co_cat','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("CONAI_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [CONAI_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN CONAI_A, INFORMAR AL DPTO INFORMATICA") <= 0
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
conSOL=0
conSOLP=0
conCONAI=0


tresult=sqlexec(tconnect,'select * from COSER_A.dbo.art','v_SC')

do while !EOF('v_SC')	

	*Calculo de IVA y Resta de Precios
		IVA_precio1=(v_SC.prec_vta1*1.12)-v_SC.prec_vta1
		IVA_precio2=(v_SC.prec_vta2*1.12)-v_SC.prec_vta2
		IVA_precio3=(v_SC.prec_vta3*1.12)-v_SC.prec_vta3
		IVA_precio4=(v_SC.prec_vta4*1.12)-v_SC.prec_vta4
		IVA_precio5=(v_SC.prec_vta5*1.12)-v_SC.prec_vta5

	*Calc Precios prueba de articulos
		noIVA_prec_vta1=v_SC.prec_vta1-IVA_precio1
		noIVA_prec_vta2=v_SC.prec_vta2-IVA_precio2
		noIVA_prec_vta3=v_SC.prec_vta3-IVA_precio3
		noIVA_prec_vta4=v_SC.prec_vta4-IVA_precio4
		noIVA_prec_vta5=v_SC.prec_vta5-IVA_precio5

	*ART_A
		tresult1=sqlexec(tconnect1,'select * from ART_A.dbo.art where co_art=?v_SC.co_art','v_resultado')
		if EOF('v_resultado')
			
			ins="INSERT INTO [ART_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1)"+;
			" VALUES (?v_SC.co_art,?v_SC.art_des,?v_SC.co_lin,?v_SC.co_cat,?v_SC.co_subl,?v_SC.co_color,?v_SC.procedenci,"+;
			"'0000000001',?v_SC.uni_venta,?v_SC.suni_venta,?v_SC.tipo,?v_SC.tipo_imp,?v_SC.comentario,?v_SC.porc_cos,?v_SC.cos_merc,"+;
			"?v_SC.prec_vta1, ?v_SC.prec_vta2, ?v_SC.prec_vta3, ?v_SC.prec_vta4, ?v_SC.prec_vta5, ?v_SC.dis_cen, ?v_SC.tipo_cos, ?v_SC.campo1 )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"ART_A Error sql Insertando ART 1, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_SC.co_art)
			   Return .F.
			else
				con=con+1
				*MESSAGEBOX("ART_A: SE INSERTO UN NUEVO ARTICULO: " + v_SC.co_art)	
			ENDIF
		ENDIF


	*COSEP_A
		tresult1=sqlexec(tconnect1,'select * from COSEP_A.dbo.art where co_art=?v_SC.co_art','v_resultado')
		if EOF('v_resultado')
			
			ins="INSERT INTO [COSEP_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1)"+;
			" VALUES (?v_SC.co_art,?v_SC.art_des,?v_SC.co_lin,?v_SC.co_cat,?v_SC.co_subl,?v_SC.co_color,?v_SC.procedenci,"+;
			"'0000000001',?v_SC.uni_venta,?v_SC.suni_venta,?v_SC.tipo,?v_SC.tipo_imp,?v_SC.comentario,?v_SC.porc_cos,?v_SC.cos_merc,"+;
			"?v_SC.prec_vta1, ?v_SC.prec_vta2, ?v_SC.prec_vta3, ?v_SC.prec_vta4, ?v_SC.prec_vta5, ?v_SC.dis_cen, ?v_SC.tipo_cos, ?v_SC.campo1 )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"COSEP_A Error sql Insertando ART 1, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_SC.co_art)
			   Return .F.
			else
				conCOSEP=conCOSEP+1
				*MESSAGEBOX("COSEP_A: SE INSERTO UN NUEVO ARTICULO: " + v_SC.co_art)	
			ENDIF
		ENDIF

	*SOL_A
		tresult1=sqlexec(tconnect1,'select * from SOL_A.dbo.art where co_art=?v_SC.co_art','v_resultado')
		if EOF('v_resultado')
			
			ins="INSERT INTO [SOL_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1)"+;
			" VALUES (?v_SC.co_art,?v_SC.art_des,?v_SC.co_lin,?v_SC.co_cat,?v_SC.co_subl,?v_SC.co_color,?v_SC.procedenci,"+;
			"'0000000001',?v_SC.uni_venta,?v_SC.suni_venta,?v_SC.tipo,?v_SC.tipo_imp,?v_SC.comentario,?v_SC.porc_cos,?v_SC.cos_merc,"+;
			"?v_SC.prec_vta1, ?v_SC.prec_vta2, ?v_SC.prec_vta3, ?v_SC.prec_vta4, ?v_SC.prec_vta5, ?v_SC.dis_cen, ?v_SC.tipo_cos, ?v_SC.campo1 )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"SOL_A Error sql Insertando ART 1, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_SC.co_art)
			   Return .F.
			else
				conSOL=conSOL+1
				*MESSAGEBOX("SOL_A: SE INSERTO UN NUEVO ARTICULO: " + v_SC.co_art)	
			ENDIF
		ENDIF

	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.art where co_art=?v_SC.co_art','v_resultado')
		if EOF('v_resultado')
			
			ins="INSERT INTO [SOLP_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1)"+;
			" VALUES (?v_SC.co_art,?v_SC.art_des,?v_SC.co_lin,?v_SC.co_cat,?v_SC.co_subl,?v_SC.co_color,?v_SC.procedenci,"+;
			"'0000000001',?v_SC.uni_venta,?v_SC.suni_venta,?v_SC.tipo,?v_SC.tipo_imp,?v_SC.comentario,?v_SC.porc_cos,?v_SC.cos_merc,"+;
			"?v_SC.prec_vta1, ?v_SC.prec_vta2, ?v_SC.prec_vta3, ?v_SC.prec_vta4, ?v_SC.prec_vta5, ?v_SC.dis_cen, ?v_SC.tipo_cos, ?v_SC.campo1 )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"SOLP_A Error sql Insertando ART 1, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_SC.co_art)
			   Return .F.
			else
				conSOLP=conSOLP+1
				*MESSAGEBOX("SOLP_A: SE INSERTO UN NUEVO ARTICULO: " + v_SC.co_art)	
			ENDIF
		ENDIF

	*CONAI_A
		tresult1=sqlexec(tconnect1,'select * from CONAI_A.dbo.art where co_art=?v_SC.co_art','v_resultado')
		if EOF('v_resultado')
			
			ins="INSERT INTO [CONAI_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1)"+;
			" VALUES (?v_SC.co_art,?v_SC.art_des,?v_SC.co_lin,?v_SC.co_cat,?v_SC.co_subl,?v_SC.co_color,?v_SC.procedenci,"+;
			"'0000000001',?v_SC.uni_venta,?v_SC.suni_venta,?v_SC.tipo,?v_SC.tipo_imp,?v_SC.comentario,?v_SC.porc_cos,?v_SC.cos_merc,"+;
			"?v_SC.prec_vta1, ?v_SC.prec_vta2, ?v_SC.prec_vta3, ?v_SC.prec_vta4, ?v_SC.prec_vta5, ?v_SC.dis_cen, ?v_SC.tipo_cos, ?v_SC.campo1 )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"CONAI_A Error sql Insertando ART 1, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_SC.co_art)
			   Return .F.
			else
				conCONAI=conCONAI+1
				*MESSAGEBOX("CONAI_A: SE INSERTO UN NUEVO ARTICULO: " + v_SC.co_art)	
			ENDIF
		ENDIF
skip in v_SC
enddo

MESSAGEBOX('Articulos Insertados')
*MESSAGEBOX(con)
MESSAGEBOX(conCOSEP)
MESSAGEBOX(conSOL)
MESSAGEBOX(conSOLP)
MESSAGEBOX(conCONAI)

*************************************************************************
*ACTUALIZACION DE ARTICULOS*
*************************************************************************
*ART_A
	act="update [ART_A].[DBO].[ART] set art_des=COSER_A.art_des, comentario=COSER_A.comentario, porc_cos=COSER_A.porc_cos, "+;
	"prec_vta1=COSER_A.prec_vta1, prec_vta2=COSER_A.prec_vta2, prec_vta3=COSER_A.prec_vta3, prec_vta4=COSER_A.prec_vta4, prec_vta5=COSER_A.prec_vta5, "+;
	"fec_prec_v=COSER_A.fec_prec_v, fec_prec_2=COSER_A.fec_prec_2, fec_prec_3=COSER_A.fec_prec_3, fec_prec_4=COSER_A.fec_prec_4, fec_prec_5=?fechaHoy,campo7=?fechaHoy, campo8=?horaHoy, " +; 
	"COS_PROV=COSER_A.COS_PROV, fec_cos_p2=COSER_A.fec_cos_p2, cos_merc=COSER_A.cos_merc, fec_cos_me=COSER_A.fec_cos_me, tipo_cos=COSER_A.tipo_cos, dis_cen=COSER_A.dis_cen, campo1=COSER_A.campo1 "+;
	"FROM COSER_A.dbo.art "+; 
	"AS COSER_A inner join ART_A.dbo.art as ART_A on COSER_A.co_art=ART_A.co_art"

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en ART_A!") <= 0
	    MESSAGEBOX(v_SC.co_art)
		Return .F.
	ENDIF

*COSEP_A
	act="update [COSEP_A].[DBO].[ART] set art_des=COSER_A.art_des, comentario=COSER_A.comentario, porc_cos=COSER_A.porc_cos, "+;
	"prec_vta1=COSER_A.prec_vta1, prec_vta2=COSER_A.prec_vta2, prec_vta3=COSER_A.prec_vta3, prec_vta4=COSER_A.prec_vta4, prec_vta5=COSER_A.prec_vta5, "+;
	"fec_prec_v=COSER_A.fec_prec_v, fec_prec_2=COSER_A.fec_prec_2, fec_prec_3=COSER_A.fec_prec_3, fec_prec_4=COSER_A.fec_prec_4, fec_prec_5=?fechaHoy,campo7=?fechaHoy, campo8=?horaHoy, " +; 
	"COS_PROV=COSER_A.COS_PROV, fec_cos_p2=COSER_A.fec_cos_p2, cos_merc=COSER_A.cos_merc, fec_cos_me=COSER_A.fec_cos_me, tipo_cos=COSER_A.tipo_cos, dis_cen=COSER_A.dis_cen, campo1=COSER_A.campo1 "+;
	"FROM COSER_A.dbo.art "+; 
	"AS COSER_A inner join COSEP_A.dbo.art as COSEP_A on COSER_A.co_art=COSEP_A.co_art"

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en COSEP_A!") <= 0
	    MESSAGEBOX(v_SC.co_art)
		Return .F.
	ENDIF

*SOL_A
	act="update [SOL_A].[DBO].[ART] set art_des=COSER_A.art_des, comentario=COSER_A.comentario, porc_cos=COSER_A.porc_cos, "+;
	"prec_vta1=COSER_A.prec_vta1, prec_vta2=COSER_A.prec_vta2, prec_vta3=COSER_A.prec_vta3, prec_vta4=COSER_A.prec_vta4, prec_vta5=COSER_A.prec_vta5, "+;
	"fec_prec_v=COSER_A.fec_prec_v, fec_prec_2=COSER_A.fec_prec_2, fec_prec_3=COSER_A.fec_prec_3, fec_prec_4=COSER_A.fec_prec_4, fec_prec_5=?fechaHoy,campo7=?fechaHoy, campo8=?horaHoy, " +; 
	"COS_PROV=COSER_A.COS_PROV, fec_cos_p2=COSER_A.fec_cos_p2, cos_merc=COSER_A.cos_merc, fec_cos_me=COSER_A.fec_cos_me, tipo_cos=COSER_A.tipo_cos, dis_cen=COSER_A.dis_cen, campo1=COSER_A.campo1 "+;
	"FROM COSER_A.dbo.art "+; 
	"AS COSER_A inner join SOL_A.dbo.art as SOL_A on COSER_A.co_art=SOL_A.co_art"

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en SOL_A!") <= 0
	    MESSAGEBOX(v_SC.co_art)
		Return .F.
	ENDIF

*SOLP_A
	act="update [SOLP_A].[DBO].[ART] set art_des=COSER_A.art_des, comentario=COSER_A.comentario, porc_cos=COSER_A.porc_cos, "+;
	"prec_vta1=COSER_A.prec_vta1, prec_vta2=COSER_A.prec_vta2, prec_vta3=COSER_A.prec_vta3, prec_vta4=COSER_A.prec_vta4, prec_vta5=COSER_A.prec_vta5, "+;
	"fec_prec_v=COSER_A.fec_prec_v, fec_prec_2=COSER_A.fec_prec_2, fec_prec_3=COSER_A.fec_prec_3, fec_prec_4=COSER_A.fec_prec_4, fec_prec_5=?fechaHoy,campo7=?fechaHoy, campo8=?horaHoy, " +; 
	"COS_PROV=COSER_A.COS_PROV, fec_cos_p2=COSER_A.fec_cos_p2, cos_merc=COSER_A.cos_merc, fec_cos_me=COSER_A.fec_cos_me, tipo_cos=COSER_A.tipo_cos, dis_cen=COSER_A.dis_cen, campo1=COSER_A.campo1 "+;
	"FROM COSER_A.dbo.art "+; 
	"AS COSER_A inner join SOLP_A.dbo.art as SOLP_A on COSER_A.co_art=SOLP_A.co_art"

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en SOLP_A!") <= 0
	    MESSAGEBOX(v_SC.co_art)
		Return .F.
	ENDIF

*CONAI_A
	act="update [CONAI_A].[DBO].[ART] set art_des=COSER_A.art_des, comentario=COSER_A.comentario, porc_cos=COSER_A.porc_cos, "+;
	"prec_vta1=COSER_A.prec_vta1, prec_vta2=COSER_A.prec_vta2, prec_vta3=COSER_A.prec_vta3, prec_vta4=COSER_A.prec_vta4, prec_vta5=COSER_A.prec_vta5, "+;
	"fec_prec_v=COSER_A.fec_prec_v, fec_prec_2=COSER_A.fec_prec_2, fec_prec_3=COSER_A.fec_prec_3, fec_prec_4=COSER_A.fec_prec_4, fec_prec_5=?fechaHoy,campo7=?fechaHoy, campo8=?horaHoy, " +; 
	"COS_PROV=COSER_A.COS_PROV, fec_cos_p2=COSER_A.fec_cos_p2, cos_merc=COSER_A.cos_merc, fec_cos_me=COSER_A.fec_cos_me, tipo_cos=COSER_A.tipo_cos, dis_cen=COSER_A.dis_cen, campo1=COSER_A.campo1 "+;
	"FROM COSER_A.dbo.art "+; 
	"AS COSER_A inner join CONAI_A.dbo.art as CONAI_A on COSER_A.co_art=CONAI_A.co_art"

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en CONAI_A!") <= 0
	    MESSAGEBOX(v_SC.co_art)
		Return .F.
	ENDIF



MESSAGEBOX(":.:Proceso Actualizacion De Precios --> FINALIZADO:.:",48,"::Dpto Informatica :) Compresores Servicios::")

