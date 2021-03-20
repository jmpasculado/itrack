<?php
require_once 'deliveryreport_dd.php';
class deliveryreport_html extends html
{
    function deliveryreport_html()
    {
        $this->fields = deliveryreport_dd::load_dictionary();
        $this->relations = deliveryreport_dd::load_relationships();
        $this->subclasses = deliveryreport_dd::load_subclass_info();
    }
}
