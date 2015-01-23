**********************************************************************************************************
*** ACTUALIZACION DE ARTICULOS DESPUES DE NUEVA COMPRA (com1_sf)
**********************************************************************************************************
*** Al momento de guardar una compra hace los procesos para recalcular los precios dependiendo los margenes
*** de ganancia preestablecidos. 
**********************************************************************************************************
*** Roy Enero 2015
**********************************************************************************************************

MESSAGEBOX(":.: Proceso Actualizacion De Precios Despues de Nueva Compra :.: "+Chr(13)+"-->  ACTIVADO  <--",64,"::Dpto Informatica :) Compresores Servicios::")

alias_w=alias() 
*** Taking values
x1_fact_num=vcompras.fact_num

If serversql
	tconnect = SQLCONECTAR()
	If  mensaje_sql(tconnect,0) <= 0
		Return .F.
	Endif
ENDIF

tresult=sqlexec(tconnect,'select glob_desc,porc_gdesc from compras where fact_num =?x1_fact_num','v_comp')
If mensaje_sql(tresult,1,"Error sql Compras") <= 0
   Return .F.
ENDIF

tresult=sqlexec(tconnect,'select * from reng_com where fact_num =?x1_fact_num','v_tfac')
If mensaje_sql(tresult,1,"Error sql reng_com") <= 0
   Return .F.
ENDIF

DO WHILE !EOF('v_tfac')

	*** glob_desc (Descuento Global) y porc_gdesc (%Descuento Global)
	*** El descuento por renglon no es necesario calcularlo aqui.

	*** After making a cursor, values can be accessed without the prefix of the cursor. If and only if no other cursor has been declared.
	*** If another cursor is declared the prefix (cursor name) is obviously needed

	x1_art=v_tfac.co_art
	costo=(v_tfac.reng_neto/v_tfac.total_art)
	porc_1=cast(v_comp.porc_gdesc as float(4,2))/100

	porc=cast(porc_1 as float(4,2))
	mont_por=costo*porc
	costo=costo-mont_por
	
	tresult=sqlexec(tconnect,'select co_art,cos_merc,prec_vta3,fec_ult_co,co_subl from art where co_art=?x1_art','v_tart')
	If mensaje_sql(tresult,1,"Error sql Articulos") <= 0
	   Return .F.
	ENDIF

	tresult=sqlexec(tconnect,'select co_subl,mv1,mv2,mv3,mv4,flete,iva from aAa_margenesG where co_subl=?v_tart.co_subl','V_SUBLIN')
	If  mensaje_sql(tresult,1,"Error realizando select") <= 0
		Return .F.
	Endif

	mv1=v_sublin.mv1
	mv2=v_sublin.mv2
	mv3=v_sublin.mv3
	mv4=v_sublin.mv4
	flete=v_sublin.flete
	iva=v_sublin.iva

	*** *** MESSAGEBOX("Articulo: "+Chr(9)+x1_art+Chr(13)+"Costo de compra(Nuevo): "+Chr(9)+ALLTRIM(STR(costo,8,2))+Chr(13)+"Costo anterior(Viejo): "+Chr(9)+ALLTRIM(STR(v_tart.cos_merc,8,2)))

	*** If New Cost is > old. Saves it. Else Saves the old. 
	if(costo<v_tart.cos_merc)
		costo=v_tart.cos_merc	
	endif

	*** Setting prices depending on values on aAa_margenesG
	if(mv1=0 OR flete=0)
		precio1=0
	else
		precio1=((costo/flete)/mv1)*iva
	endif

	if(mv2=0 OR flete=0)
		precio2=0
	else
		precio2=((costo/flete)/mv2)*iva
	endif
	if(mv3=0 OR flete=0)
		precio3=0
	else
		precio3=((costo/flete)/mv3)*iva
	endif
	if(mv4=0 OR flete=0)
		precio4=0
	else
		precio4=((costo/flete)/mv4)*iva
	endif

	*** Testing
	*** *** MessageBox("Costo MAYOR: "+Chr(9)+ALLTRIM(STR(costo,8,2))+Chr(13)+"Precio 3: "+Chr(9)+ALLTRIM(STR(precio3,8,2)))


	*Roy: Getting and formating date and time
	*NOTE: string >> fechaHora && datetime >> convert(datetime,fechaHora,131)
	fechaHoy=date()
	horaHoy=time()
	fechaHora=DATETIME(YEAR(fechaHoy), MONTH(fechaHoy), DAY(fechaHoy), VAL(LEFT(horaHoy, 2)), VAL(SUBS(horaHoy, 4, 2)), VAL(RIGHT(horaHoy, 2)))

	sql_con= "update art set cos_merc=?costo, fec_cos_me=?v_tart.fec_ult_co," +;
	"prec_vta1=?precio1, prec_vta2=?precio2, prec_vta3=?precio3, prec_vta4=?precio4, " +;
	"fec_prec_v=?fechaHoy, fec_prec_2=?fechaHoy, fec_prec_3=?fechaHoy,fec_prec_4=?fechaHoy " +;
	" where co_art=?v_tfac.co_art "

	tresult=sqlexec(tconnect,sql_con)
	If mensaje_sql(tresult,1,"Error sql Actualizando Costos") <= 0
		Return .F.
	ENDIF

	if(v_tart.prec_vta3<>0)
		pre_v=cast(v_tart.prec_vta3 as float(8,2))
		pre_v=pre_v/1.12
		cos_pro=cast(costo as float(3,2))
		this_margen=(((pre_v-cos_pro)/pre_v)*100)-1
		
		*** MessageBox( ALLTRIM(STR(this_margen,8,2)) )

		tresult=sqlexec(tconnect,'update art set porc_cos=?this_margen where co_art=?v_tfac.co_art')
		If mensaje_sql(tresult,1,"Error sql actualizando this_margen") <= 0
			Return .F.
		ENDIF
	endif
		
	SKIP IN v_tfac
ENDDO
********************************************************************************************************************
*************************************************************************
*** Proceso Acualizado Por Wender y Roy el 25/04/12, hace:				*
*Cuando el CostoNuevo>CostoGuardado Actualiza Precios y Costo			*
*Cuando el CostoNuevo<CostoGuardado ACtualiza TODO excepto El Costo!!!! *
*							GG ROY ^.^!									*
*************************************************************************
*** Se agrego condicion para que en caso1... tome el costo nuevo 		*
*** y en caso 2 tome el costo viejo(el de la tabla art)					*
*** Proceso Acualizado Por Roy el 01/05/12								*
*************************************************************************