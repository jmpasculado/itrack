<?php
require_once 'inventory_dd.php';
class inventory_html extends html
{
    function inventory_html()
    {
        $this->fields = inventory_dd::load_dictionary();
        $this->relations = inventory_dd::load_relationships();
        $this->subclasses = inventory_dd::load_subclass_info();
    }
}
