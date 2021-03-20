<?php
require_once 'salesinvoice_dd.php';
class salesinvoice_html extends html
{
    function salesinvoice_html()
    {
        $this->fields = salesinvoice_dd::load_dictionary();
        $this->relations = salesinvoice_dd::load_relationships();
        $this->subclasses = salesinvoice_dd::load_subclass_info();
    }
}
