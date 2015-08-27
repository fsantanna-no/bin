<?
        /**********************************************************/
        /* Funcao PHP para envio de torpedos para celulares CLARO */
        /* Autor: Eduardo Bacchi Kienetz                          */
        /* http://www.noticiaslinux.com.br/eduardo/               */
        /*   dddto = DDD do telefone destinatario                 */
        /*   telto = TELEFONE do destinatario                     */
        /*   txt   = TEXTO da mensagem                            */
        /*   dddde = DDD do remetente                             */
        /*   telde = TELEFONE do remetente                        */
        /*   nomde = NOME do remetente                            */
        /**********************************************************/
        function smsClaro($dddto="",$telto="",$txt="",$dddde="",$telde="",$nomde=""){
                // se remetente + texto exceder 136 a msg nao eh enviada 
                // adicionalmente poderia testar se os parametros estao em branco, etc
                // mas na verdade os unicos obrigatorios sao DDD e TEL do destinatario
                // e nome do remetente, entao o limite tende a aumentar...
                // A soma do tamanho de todos os parametros nao pode exceder 160.
                if( (strlen($nomde)+strlen($txt)) >136 ) return false;
        	$fp  = fsockopen ("www2.claro.com.br", 80, $errno);
                $txt = urlencode(stripslashes($txt));
	        if ($fp) {
		        $conectar =  "GET /torpedoweb/clarotw_envia.asp?ddd_para=$dddto&telefone_para=$telto&nome_de=$nomde&ddd_de=$dddde&telefone_de=$telde&msg=$txt HTTP/1.0\r\nHost: www2.claro.com.br\r\n\r\n";
        		fputs ($fp, $conectar);
	        	$resultado = "";
		        while (!feof($fp)) $resultado .= fgets ($fp,128);
        		fclose ($fp);
        		//Se quiser imprimir a mensagem de retorno
        		//Me parece inutil pois sempre mostra fl_enviado=true
                        //echo $resultado;
        	        return true;  //SUPONHO que tenha sido enviada
                }
                else return false;
        }
        /* teste de envio */
        if(smsClaro("21","99219771","testando texto?","21","97650862","Kienetz"))
                echo "Mensagem possivelmente enviada";
        else    echo "Mensagem NAO enviada";
?>

