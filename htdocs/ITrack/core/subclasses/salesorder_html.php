<?php
require_once 'salesorder_dd.php';
class salesorder_html extends html
{
    function salesorder_html()
    {
        $this->fields = salesorder_dd::load_dictionary();
        $this->relations = salesorder_dd::load_relationships();
        $this->subclasses = salesorder_dd::load_subclass_info();
    }
}
