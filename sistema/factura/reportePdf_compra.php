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
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div id="page_pdf">
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
			<td class="info_empresa">
				<?php
					if($result_conf> 0){
						$moned = $configuracion['moneda'];
					}
				 ?>
				<div>
					<span class="h2"><?php echo strtoupper($configuracion['nombre']); ?></span>
					<p><?php echo $configuracion['razon_social']; ?></p>
					<p><?php echo $configuracion['direccion']; ?></p>
					<p>RUC: <?php echo $configuracion['ruc']; ?></p>
					<p>Teléfono: <?php echo $configuracion['telefono']; ?></p>
					<p>Email: <?php echo $configuracion['email']; ?></p>
					<br>
				</div>
			</td>
			<td class="info_factura">

			</td>
		</tr>
		
	</table>

	<table id="factura_detalle">
			<thead>
				<tr>
					<th>No.</th>
					<th>Fecha / Hora</th>
					<th>Proveedor</th>
					<th>Usuario</th>
					<th>Estado</th>
					<th class="">Total Venta</th>
				</tr>
			</thead>
			<tbody id="detalle_productos">
				<?php

				if ($result > 0) {
					$ventas_totales = 0;
					while ($data = mysqli_fetch_array($query)) {
						if ($data['status'] == 1) {
							$estatus = '<span class="pagada">Pagada</span>';
						}else if ($data['status'] == 3) {
							$estatus = '<span class="credito">Crédito</span>';
						}

						$nofactura = $data["nocompra"];
						$fecha = $data["fecha"];
						$cliente = $data["cliente"];
						$vendedor = $data["vendedor"];
						$status = $estatus;
						$totalfactura= number_format($data["totalcompra"],2);
						$totalfact = $data["totalcompra"];
						$ventas_totales = $ventas_totales + $totalfact;

						?>
						    <tr id="">
							<td><?php echo $nofactura; ?></td>
							<td><?php echo $fecha; ?></td>
							<td><?php echo $cliente; ?></td>
							<td><?php echo $vendedor; ?></td>
							<td class="estado"><?php echo $status; ?></td>
							<td class="totalfactura"><?php echo $moned.' '.$totalfactura; ?></td>
							</tr>;

							</tbody>
							<?php
							} ?>
							<tfoot id="detalle_totales">
								<tr>
									<td colspan="4" class="textright"><h2>Compras totales</h2><span></span></td>
									<td></td>
									<td class=""><span><?php echo $moned.' '.number_format($ventas_totales,2);?></span></td>
								</tr>
								
							</tfoot>

							<?php
							
					}else{ ?>
						<tr>
									<td colspan="6" class=""><h2>No se encontraron resultados :(</h2><span></span></td>
								</tr>
				<?php	}
				?>
						
			
	</table>
	<div>
		<!--<p class="nota">Si usted tiene preguntas sobre esta venta, <br>pongase en contacto con nombre, teléfono y Email</p>-->
		<!--<h4 class="label_gracias">¡Gracias por su compra!</h4>-->
	</div>

</div>

</body>
</html>