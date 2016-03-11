*******************************************************************************
*** Reporte y proceso adicional
*** Costos en dolares automatico
*** Ing. RoyCalderon -- 21 10 2015 
*** Actualiza el precio de ventas 1 automaticamente dependiendo el dolar ingresado en base de datos (Que se puede cambiar usando el proceso3 en articulos)
*******************************************************************************

fecha=date()

If serversql
tconnect = SQLCONECTAR()
If  mensaje_sql(tconnect,0) <= 0
Return .F.
Endif
ENDIF

twhere=''

if !empty(tdesde(1))
	twhere="where co_art BETWEEN ?tdesde(1) and ?thasta(1)"
else
	if !empty(tdesde(2))
		twhere="where co_subl BETWEEN ?tdesde(2) and ?thasta(2)"
	endif
endif

******************************************************************************************************
*** Dollar
******************************************************************************************************
tresult=sqlexec(tconnect,'SELECT vfloat FROM COSER_A.DBO.aAa_Globals where name="dolar"', 'v_dolar')
If mensaje_sql(tresult,1,"Error Dolar") <= 0
	Return .F.
ENDIF
dolar=v_dolar.vfloat
******************************************************************************************************
*** ART
******************************************************************************************************
tresult=sqlexec(tconnect,'select co_art,co_subl from art '+ twhere,'v_art')
If mensaje_sql(tresult,1,"Error primer sql art") <= 0
	Return .F.
ENDIF

DO WHILE !EOF('v_art')
	x1_co_subl1=v_art.co_subl
	x1_art=v_art.co_art
	*****actualizandoCosto***** 
	tresult=sqlexec(tconnect,'select costoDolares,porcNacionalizacion FROM COSER_A.DBO.aAa_artDolares where co_art=?x1_art','v_artDolares')
	If	(v_artDolares.costoDolares>0)
		costo=((v_artDolares.porcNacionalizacion/100*v_artDolares.Icosto)+v_artDolares.Icosto)*dolar

		tresult=sqlexec(tconnect,'select mv1,flete,iva from aAa_margenesG where co_subl=?x1_co_subl1','V_SUBLIN')
		If  mensaje_sql(tresult,1,"Error realizando select") <= 0
		Return .F.
		Endif

		mv1=v_sublin.mv1
		flete=v_sublin.flete
		iva=v_sublin.iva

		if(mv1=0)
			precio1=0
		else
			precio1=((costo/flete)/mv1)*iva
		endif

		******************************************************************************************************
		*** Updating Art 
		******************************************************************************************************
		sql_con= "update art set " +;
		"cos_prov=?costo, FEC_COS_P2=?fecha, "+;
		"prec_vta1=?precio1,  " +;
		"fec_prec_v=?fecha, " +;
		" where co_art=?x1_art"

		tresult=sqlexec(tconnect,sql_con)
		If mensaje_sql(tresult,1,"Error sql Actualizando Costos y Precios") <= 0
			Return .F.
		ENDIF
		precio1=0

	EndIf
	SKIP IN v_art
ENDDO

messagebox(":.: Proceso Actualizacion De Articulos por Divisas --> COMPLETADO :.:",64,"Dpto Informatica :) :: Compresores Servicios::")