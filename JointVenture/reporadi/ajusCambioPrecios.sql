*******************************************************************************
*** 2^ Actualizacion despues de Cambio de Precios Automaticos
*** Ing. RoyCalderon 
*** cambia precios despues de actualizar margenes
*******************************************************************************
*** 21 10 2015 
*** Se elimino la modificacion de prec_vta1 ya que este se usa en proceso de dolares...
*******************************************************************************

If serversql
	tconnect = SQLCONECTAR()
	If  mensaje_sql(tconnect,0) <= 0
		Return .F.
	Endif
ENDIF

if !empty(tdesde(1))
	twhere=" co_art BETWEEN ?tdesde(1) and ?thasta(1)"
else
if !empty(tdesde(2))
	twhere=" co_subl BETWEEN ?tdesde(2) and ?thasta(2)"
endif
endif


tresult=sqlexec(tconnect,'select co_art,cos_merc,fec_ult_co,co_subl from art where '+ twhere,'v_art')
If mensaje_sql(tresult,1,"Error primer sql art") <= 0
   Return .F.
ENDIF

DO WHILE !EOF('v_art')


x1_act=1
costo=v_art.cos_merc
x1_co_subl1=co_subl
x1_art=v_art.co_art

tresult=sqlexec(tconnect,'select co_subl,mv2,mv3,mv4,flete,iva from aAa_margenesG where co_subl=?x1_co_subl1','V_SUBLIN')
If  mensaje_sql(tresult,1,"Error realizando select") <= 0
	Return .F.
Endif

mv2=v_sublin.mv2
mv3=v_sublin.mv3
mv4=v_sublin.mv4
flete=v_sublin.flete
iva=v_sublin.iva

if(mv2=0)
	x1_act=0
	precio2=0
else
	x1_act=0
	precio2=((costo/flete)/mv2)*iva
endif
if(mv3=0)
	x1_act=0
	precio3=0
else
	x1_act=0
	precio3=((costo/flete)/mv3)*iva
endif
if(mv4=0)
	x1_act=0
	precio4=0
else
	x1_act=0
	precio4=((costo/flete)/mv4)*iva
endif

precio5=0	

	fecha=date()
******************************************************************************************************
	sql_con= "update art set " +;
	"prec_vta2=?precio2, prec_vta3=?precio3, prec_vta4=?precio4,prec_vta5=?precio5, " +;
	"fec_prec_2=?fecha, fec_prec_3=?fecha,fec_prec_4=?fecha,fec_prec_5=?fecha" +;
	" where co_art=?x1_art"
	
	if(x1_act=0)
		tresult=sqlexec(tconnect,sql_con)
		If mensaje_sql(tresult,1,"Error sql Actualizando Precios") <= 0
		   Return .F.
		ENDIF
		tresult=sqlexec(tconnect,'select co_art,cos_merc,prec_vta3,prec_vta5,fec_ult_co,co_subl from art where co_art=?x1_art','v_art1')
		If mensaje_sql(tresult,1,"Error sql fecha Articulos") <= 0
		   Return .F.
		ENDIF	
	

		if(v_art1.prec_vta3<>0)
			pre_v=cast(v_art1.prec_vta3 as float(8,2))
			pre_v=pre_v/1.12
			cos_pro=cast(costo as float(3,2))
			mg=((pre_v-cos_pro)/pre_v)*100
			mg=mg-1
			tresult=sqlexec(tconnect,'update art set porc_cos=?mg where co_art=?v_art.co_art')
			If mensaje_sql(tresult,1,"Error sql Actualizando Costos") <= 0
		   		Return .F.
			ENDIF
			*messagebox(mg)
		endif

		
	ENDIF

precio2=0
precio3=0
precio4=0
precio5=0
SKIP IN v_art
ENDDO
messagebox("Proceso Finalizado",48,"Profit Plus Administrativo")
