***********************************************************************************
*** Ing. RoyCalderon			 												***
*** Actualiza el Precio en base al costo colocado el text y el margen minimo	***
*** Trabaja con costo reposicion 												***
***********************************************************************************

*******************************
*** Precio *** click()	 	***
*******************************

PARAMETERS pForm1
costo=cast(thisform.ultimocosto.value as float(8,2))
	x1_act=0
If serversql
	tconnect = SQLCONECTAR()
	If  mensaje_sql(tconnect,0) <= 0
		Return .F.
	Endif
Endif

tresult=sqlexec(tconnect,'select co_subl,mv1,mv2,mv3,mv4,flete,iva from aAa_margenesG where co_subl=?x1_co_subl1','V_SUBLIN')
If  mensaje_sql(tresult,"Error realizando select") <= 0
	Return .F.
Endif
mv1=v_sublin.mv1
mv2=v_sublin.mv2
mv3=v_sublin.mv3
mv4=v_sublin.mv4
flete=v_sublin.flete
iva=v_sublin.iva

*flete1=float(flete)/100
if(mv1=0)
	precio1=0
else
	precio1=((costo/flete)/mv1)*iva
endif
if(mv2=0)
	precio2=0
else
	precio2=((costo/flete)/mv2)*iva
endif
if(mv3=0)
	precio3=0
else
	precio3=((costo/flete)/mv3)*iva
endif
if(mv4=0)
	precio4=0
else
	precio4=((costo/flete)/mv4)*iva
endif

precio5=0	




***************************************************************************************************************
	Thisform.visible=.f.
	_screen.activeform.pageframe1.page4.cos_merc1.value=costo
	_screen.activeform.pageframe1.page4.prec_vta11.value=precio1
	_screen.activeform.pageframe1.page4.prec_vta21.value=precio2
	_screen.activeform.pageframe1.page4.prec_vta31.value=precio3
	_screen.activeform.pageframe1.page4.prec_vta41.value=precio4
	_screen.activeform.pageframe1.page4.prec_vta51.value=precio5

	*_screen.activeform.pageframe1.page4.fec_cos_prov1.value=date()
	_screen.activeform.pageframe1.page4.fec_cos_mer1.value=date()
	
	_screen.activeform.pageframe1.page4.fec_prec_v11.value=date()
	_screen.activeform.pageframe1.page4.fec_prec_v21.value=date()
	_screen.activeform.pageframe1.page4.fec_prec_v31.value=date()
	_screen.activeform.pageframe1.page4.fec_prec_v41.value=date()
	_screen.activeform.pageframe1.page4.fec_prec_v51.value=date()
	
		_screen.activeform.pageframe1.page4.cos_merc1.setfocus()
	
*********************************************************************************************************************
	prec_vta3=_screen.activeform.pageframe1.page4.prec_vta31.value
	prec_vta5=_screen.activeform.pageframe1.page4.prec_vta51.value

				mg=0
		
			if(prec_vta3<>0)
				pre_v=cast(prec_vta3 as float(8,2))
				pre_v=pre_v/1.12
				cos_pro=cast(costo as float(3,2))
				mg=((pre_v-cos_pro)/pre_v)*100
			endif
	_screen.activeform.pageframe1.page4.por_cos_adic.value=mg-1
**********************************************************************************************************************
costo=0
precio1=0
precio2=0
precio3=0
precio4=0
precio5=0

*******************************
*** Form1 *** init()	 	***
*******************************
PARAMETERS pForma

*******************************
*** Form1 *** load()	 	***
*******************************

PUBLIC x1_ult_cos_un,x1_por_cos_adic,x1_marg_gan11,x1_co_subl1,x1_co_art
**ultimo costo**
x1_ult_cos_un=_screen.activeform.pageframe1.page4.ult_cos_un1.value
**margen minimo**
x1_por_cos_adic=_screen.activeform.pageframe1.page4.por_cos_adic.value
**codigo de sub-linea**
x1_co_subl1=_screen.activeform.pageframe1.page1.co_subl1.value
**codigo del articulo
x1_co_art=_screen.activeform.pageframe1.page1.co_art1.value
