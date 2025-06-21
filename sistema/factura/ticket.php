<?php
	$subtotal 	= 0;
	$iva 	 	= 0;
	$impuesto 	= 0;
	$tl_sniva   = 0;
	$total 		= 0; 
 //print_r($configuracion); ?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Venta</title>
    <link rel="stylesheet" href="styleticket.css">
</head>
<body>
<?php echo $anulada; ?>
<div id="page_pdf">
	<br>
	<br>
	<table id="factura_head">
		<tr>
			<td class="logo_factura">
				<div>
					<?php 
					$imagePath = 'img/' . $configuracion['foto'];
					$imageData = base64_encode(file_get_contents($imagePath));
					?>
					<img style="width: 200px;" src="data:image/jpeg;base64,<?php echo $imageData; ?>" alt="Logo">
				</div>
			</td>
		</tr>
		<tr>
			<td class="info_empresa">

				<?php if($result_config > 0) { $iva = $configuracion['iva']; $moned = $configuracion['moneda']; ?>
				<div>
					<span class="h2"><?php echo strtoupper($configuracion['nombre']); ?></span>
					<p><?php echo $configuracion['razon_social']; ?></p>
					<p><?php echo $configuracion['direccion']; ?></p>
					<p>RUC: <?php echo $configuracion['ruc'].' &nbsp;&nbsp;Cel: '.$configuracion['telefono']; ?></p>					
				</div>
				<?php } ?>
			</td>
		</tr>
	</table>
	<table id="factura_detalle">
			<thead>
				<tr>
					<th colspan="3" class="textleft"> ------------------------------------------------------------------------------------ Descripción</th>
				</tr>
				<tr><th width="">Código</th>
					<th width="">Cantidad</th>
					<th class="" width="">Precio</th>
					<th class="" width="">Total</th>
				</tr>
				<tr>
					<th colspan="3" class="textleft"> ------------------------------------------------------------------------------------ </th>
				</tr>
			</thead>
			<tbody id="detalle_productos">
			<?php

				if($result_detalle > 0){

					while ($row = mysqli_fetch_assoc($query_productos)){
						$precio_venta = number_format($row['precio_venta'],2);
						$precio_total = number_format($row['precio_total'],2);
			 ?>
				<tr>
					<td colspan="3"width=""><?php echo $row['descripcion']; ?></td>
				</tr>
				<tr>
					<td width=""><?php echo $row['codigo']; ?></td>
					<td width=""><?php echo $row['cantidad']; ?></td>
					<td width=""><?php echo $precio_venta; ?></td>
					<td class=""><?php echo $precio_total; ?></td>
				</tr>
			<?php
						$precio_total = $row['precio_total'];
						$subtotal = round($subtotal + $precio_total, 2);
					}
				}

				$impuesto = round($subtotal * ($iva / 100), 2);
				$tl_sniva = round($subtotal - $impuesto, 2);
				$total = $tl_sniva + $impuesto;
				$tl_sniva1 = number_format($subtotal - $impuesto,2);
				$impuesto1 = number_format($subtotal * ($iva / 100), 2);
				$descuento = number_format($venta['descuento'],2);
			?>
			</tbody>
			<tfoot id="detalle_totales">
				<tr>
					<td colspan="3"><p>---------------------------------------------------------</p></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td colspan="" class=""><span>Sub total </span></td>					
					<td class=""><span> <?php echo $moned.' '.number_format($total,2); ?></span></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td colspan="" class=""><span>Descuento </span></td>					
					<td class=""><span> <?php echo $moned.' '.$descuento; ?></span></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td colspan="" class=""><span>TOTAL </span></td>					
					<td class=""><span> <?php echo $moned.' '.number_format($total-$descuento,2); ?></span></td>
				</tr>
		</tfoot>
	</table>
	<br>
	<br>
	<br>
	<div>
		<!--<p class="nota">Si usted tiene preguntas sobre esta factura, <br>pongase en contacto con nombre, teléfono y Email</p>-->
		<h4 class="label_gracias">¡Gracias por su compra!</h4>
		<p class="label_gracias">Revise su producto, no aceptamos devoluciones.</p>
	</div>

</div>

</body>
</html>