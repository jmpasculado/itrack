<?php
require_once 'purchaseorder_dd.php';
class purchaseorder_html extends html
{
    function purchaseorder_html()
    {
        $this->fields = purchaseorder_dd::load_dictionary();
        $this->relations = purchaseorder_dd::load_relationships();
        $this->subclasses = purchaseorder_dd::load_subclass_info();
    }
}
