var rails_store = {
  controllers: {
    application: {
      ready: function() {

        for (var i = 0; i < this.controllers.length; i++) {
          var regExp = new RegExp(this.controllers[i]);

          // if we're on a controller with a js ready function, call it
          if (this.page_classification.match(regExp))
            rails_store.controllers[this.controllers[i]]['ready']();
        }
        
        lightbox.init($('#shopping-basket a:has(img)'));
        this.slide_up_flash_messages($('#notice, #alert, #error'));
      },
      slide_up_flash_messages: function(flash_messages) {
        // if there are any flash messages on the page, slide them up after 5 seconds
      	if (flash_messages.length !== 0) flash_messages.animate({opacity : 1}, 5e3).slideUp('fast');
      },
      controllers: ['baskets', 'items','pages'],
      page_classification: document.getElementById('classifier').className
    }, /* end application controller */

    baskets: {
      ready: function() {
        // basket only has a show action
        rails_store.controllers.baskets.show();
      },
      show: function() {
        rails_store.controllers.baskets.prepare_quantity_forms($('.quantity_form'));
      },
      prepare_quantity_forms: function(forms) {
        if (forms.length !== 0) {

          // if we've got any forms, iterate over them
          $.each(forms, function(idx, val) {

            // cache the form el
            $form = $(val).find('form');

            // bind the rails generated success event to the anon function..
            $form.bind('ajax:success', function(event, data, status, xhr) {

              // .. which calls the success function, passing the selects & json data
              rails_store.controllers.baskets.quantity_update_success($(this).find('select'), JSON.parse(data));

            }).find('select').change(function(){

              // bind the change event of the select, so
              // that onchange we check the quantity
              var new_quantity = $(this).val();

              // ifi t's zero then we want to delete the line item
              if (new_quantity === '0') $form.attr('method', 'delete');

              // then submit the form
              $form.trigger('submit');

            });

          });

        }
      }, /* end prepare_quantity_forms */
      quantity_update_success: function(select, json_data) {

        // JSON object: "item_subtotal", "subtotal", "postage", "total"
        var table_row = select.parents('tr');

        // if the item has been deleted, rm the row
        if (json_data["action"] === "delete")	table_row.remove();
        // else change the quantity and flash the row
        else table_row.find('.item_subtotal').html(json_data["item_subtotal"]).animateHighlight();

        // and update & flash all the other related columns
        $('#basket_subtotal').html(json_data["subtotal"]).animateHighlight();
        $('#basket_postage').html(json_data["postage"]).animateHighlight();
        $('#basket_total').html(json_data["total"]).animateHighlight();

      } /* end quantity_update_success */
    }, /* end basket controller */
    items: {
      ready: function() {
        lightbox.init($('.meta a:has(img)'));
      }
    }, /* end items */
    pages: {
      ready: function() {

      }
    } /* end pages */
  } /* end controllers */ 
}

// flashes background colours
$.fn.animateHighlight = function(highlightColor, duration) {
    var highlightBg = highlightColor || "#fef6e6";
    var animateMs = duration || 1500;
		originalBg = this.parent().css("backgroundColor");
    this.stop().css("background-color", highlightBg).animate({backgroundColor: originalBg}, animateMs);
};

$(function () {
  
  rails_store.controllers.application.ready();
			
});