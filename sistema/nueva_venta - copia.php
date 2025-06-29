<?php 
	session_start();
	include "../conexion.php";
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	
	<?php include "includes/scripts.php"; ?>
	<title>Nueva Venta</title>
</head>
<body>

	<?php  
		include "includes/header.php"; 
		$user = $_SESSION['idUser'];
	$query_conf = mysqli_query($conection,"SELECT moneda FROM configuracion");
		$result_conf = mysqli_num_rows($query_conf);

				if ($result_conf > 0) {
					$info_conf = mysqli_fetch_assoc($query_conf);
					$moned = $info_conf['moneda'];
				}

				$query_proveedor = mysqli_query($conection,"SELECT * FROM cliente ");
			$array = array();

			if ($query_proveedor) {
				while ($data = mysqli_fetch_array($query_proveedor)) {
					$nombre = $data['nombre'];
					array_push($array, $nombre);
				}
			}

			//$query_caja = mysqli_query($conection,"SELECT * FROM caja WHERE usuario = $user AND status = 1");
			$query_caja = mysqli_query($conection,"SELECT * FROM caja WHERE status = 1");
            $result_caja = mysqli_fetch_array($query_caja);

          ?>
            	

	<section id="container">
		<?php if ($result_caja > 0) { ?>
		<div class="title_page">
			<h1><i class="fas fa-cube"></i> Nueva Venta</h1>
		</div>
		<div class="datos_cliente">
		<div class="action_cliente">
			<h4>Datos del Cliente</h4>
			<a href="#" class="btn_new btn_new_cliente"><i class="fas fa-plus"></i> Nuevo cliente</a>
		</div>

		<form name="form_new_cliente_venta" id="form_new_cliente_venta" class="datos">
			<input type="hidden" name="action" value="addCliente">
			<input type="hidden" id="idcliente" name="idcliente" value="" required>
			<div class="wd30">
				<label>Nombre</label>
				<input type="text" name="nom_cliente" id="nom_cliente" >
			</div>
			<div class="wd30">
				<label>RUC</label>
				<input type="text" name="nit_cliente" id="nit_cliente" disabled required>
			</div>
			<div class="wd30">
				<label>Teléfono</label>
				<input type="number" name="tel_cliente" id="tel_cliente" disabled required>
			</div>
			<div class="wd100">
				<label>Dirección</label>
				<input type="text" name="dir_cliente" id="dir_cliente" disabled required>
			</div>
			<div id="div_registro_cliente" class="wd100">
				<button type="submit" class="btn_save"><i class="far fa-save fa-lg"></i>Guardar</button>
			</div>
			</form>
		</div>
			<div class="datos_venta">
				<h4>Datos de Venta</h4>
					<div class="datos">
					<div class="wd20">
						<label>Vendedor</label>
						<p><?php echo $_SESSION['nombre'];?></p>
					</div>
					<div class="wd50">
						<label>Acciones</label>
						<div id="acciones_venta">
							<a href="#" class="btn_ok textcenter" id="btn_anular_venta" onclick="event.preventDefault(); anularVent();"><i class="fas fa-ban"></i> Anular</a>
							<a href="#" class="btn_new textcenter" id="btn_facturar_venta" style="display: none;" onclick="event.preventDefault(); facturar();"><i class="far fa-edit"></i> Procesar</a>
						</div>
					</div>
						<div class="wd20">
						<label>Tipo venta:</label>
						<select name="tipo_pago" id="tipo_pago">
							<option value="1">Contado</option>
							<option value="3">Crédito</option>
						</select>
					</div>
				</div>
				<a href="#" class="buscarProd" style="padding-top:15px; color: green; "><i class="fas fa-plus"></i> Buscar producto</a>
			</div>

			<div class="containerTable">
			<table class="tbl_venta">
				
				<thead>
					<tr>
						<th style="display:none;">ID</th>
						<th width="100px">Códigos</th>
						<th>Descripción</th>
						<th>Existencia</th>
						<th width="100px">Cantidad</th>
						<th class="">Precio</th>
						<th class="">Precio Total</th>
						<th>Acciones</th>
					</tr>
					<tr>
						<td style="display:none;"><input type="hidden" name="txt_id_producto" id="txt_id_producto" value="0" disabled></td>
						<td><input style="width: 150px;" type="text" name="txt_cod_producto" id="txt_cod_producto"></td>
						<td id="txt_descripcion">-</td>
						<td id="txt_existencia">-</td>
						<td><input type="number" name="txt_cant_producto" id="txt_cant_producto" value="0" disabled></td>
						<td><input style="width: 90px;" type="number" name="txt_precio" id="txt_precio" value="0.00" disabled></td>
						<td id="txt_precio_total" class=""><?= $moned; ?> 0.00</td>
						<td><a href="#" id="add_product_venta" class="link_add" onclick="event.preventDefault(); agregarProductoAlDetalle();" ><i class="
							fas fa-plus"></i> Agregar</a></td>
					</tr>
					<tr>
						<th style="display:none;">ID</th>
						<th>Cantidad</th>
						<th colspan="3">Descripción</th>
						<th class="">Precio</th>
						<th class="">Precio Total</th>
						<th>Acción</th>
					</tr>
				</thead>
				<tbody id="detalle_venta">
					<!--CONTENIDO AJAX-->
				</tbody>
				<tfoot id="detalle_totales">
					<!--CONTENIDO AJAX-->
					
				</tfoot>
			</table>
			</div>
		<?php   }else{?>
	   	<a href="#" class="btn_new" id="abrir_caja"><i class="fas fa-plus"></i> Abrir caja</a>
       <?php   } ?>
	</section>
	   
			 
	<?php  include "includes/footer.php"; ?>

		

	<script type="text/javascript">
		$(document).ready(function(){
			var usuarioid = '<?php echo $_SESSION['idUser']; ?>';
			serchForDetalle(usuarioid);

			var items = <?= json_encode($array); ?>;
				    $('#nom_cliente').autocomplete({
				        source: items

			});

		});

		$(document).keydown(function(tecla){
				if (tecla.keyCode == 13) {
					agregarProductoAlDetalle();
				}
				if (tecla.keyCode == 121) {
					facturar();
				}
				if (tecla.keyCode == 113) {
					anularVent();
				}
			})
	</script>

</body>


</html>