<?php
require_once 'purchaseorder_dd.php';
class purchaseorder extends data_abstraction
{
    var $fields = array();
    var $tables='purchaseorder';

    function purchaseorder()
    {
        $this->fields = purchaseorder_dd::load_dictionary();
        $this->relations = purchaseorder_dd::load_relationships();
        $this->subclasses = purchaseorder_dd::load_subclass_info();
    }

    function add($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('INSERT');
        $this->set_fields('id, Customer, DateOfDelivery, Date, Status');
        $this->set_values("'$id', '$Customer', '$DateOfDelivery', '$Date', '$Status'");
        $this->make_query(TRUE,$log_query);
    }

    function edit($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('UPDATE');
        $this->set_update("Customer = '$Customer', DateOfDelivery = '$DateOfDelivery', Date = '$Date', Status = '$Status'");
        $this->set_where("id = '$id'");
        $this->make_query(TRUE,$log_query);
    }

    function del($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('DELETE');
        $this->set_where("id = '$id'");
        $this->make_query(TRUE,$log_query);
    }

    function select($log_query=TRUE)
    {
        $this->set_query_type('SELECT');
        $result = $this->make_query(TRUE,$log_query);
        return $result;
    }

    function check_uniqueness($param)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('SELECT');
        $this->set_where("id = '$id'");
        $this->make_query(TRUE,$log_query);
        if($this->num_rows > 0) $this->is_unique = FALSE;
        else $this->is_unique = TRUE;

        return $this->is_unique;
    }

    function check_uniqueness_for_editing($param)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('SELECT');
        $this->set_where("id = '$id' AND (id != '$id')");
        $this->make_query(TRUE,$log_query);
        if($this->num_rows > 0) $this->is_unique = FALSE;
        else $this->is_unique = TRUE;

        return $this->is_unique;
    }

    function export_to_csv()
    {
        $result = $this->select();
        while($data = $result->fetch_assoc())
        {
            extract($data);

            $id = str_replace('"',"''", $id);
            $Customer = str_replace('"',"''", $Customer);
            $DateOfDelivery = str_replace('"',"''", $DateOfDelivery);
            $Date = str_replace('"',"''", $Date);
            $Status = str_replace('"',"''", $Status);

            $csv_contents .= '"' . $id . '","' . $Customer . '","' . $DateOfDelivery . '","' . $Date . '","' . $Status . '"' . "\r\n";
        }

        return $csv_contents;
    }
}
