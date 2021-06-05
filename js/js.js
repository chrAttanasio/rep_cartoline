$(document).ready(function(){
  var selected = '.is-selected';
  var s = ' ';
  var div_img = selected + s + '.container-cartolina__img';
  var i_fronte = selected + s + '.fronte';
  var i_retro = selected + s + '.retro';
  var t_fronte = selected + s + '.container-cartolina__testo__fronte';
  var t_retro = selected + s + '.container-cartolina__testo__retro';
  var t_dati = selected + s + '.container-cartolina__testo__dati-tecnici';

    $(".bottone-front").click(function(){
      $(i_fronte + ',' + t_fronte + ',' + div_img).removeClass('hide');
      $(t_dati + ',' + t_retro + ',' + i_retro).addClass('hide');
    });

    $(".bottone-back").click(function(){
      $(i_retro+','+ t_retro + ','+ div_img).removeClass('hide');
      $(i_fronte+','+t_dati+','+t_fronte).addClass('hide');
    });

    $(".data").click(function(){
      $(div_img + ',' + t_fronte + ',' + t_retro).addClass('hide');
      $(t_dati).removeClass('hide');
    });

    $('.container-flickity').flickity({
      // options
      cellAlign: 'center',
      contain: false,
      autoPlay: false,
      draggable: true,
      pageDots: false,
      wrapAround: false,
      pauseAutoPlayOnHover: false,
      prevNextButtons: true,
      adaptiveHeight: false
    });
  });