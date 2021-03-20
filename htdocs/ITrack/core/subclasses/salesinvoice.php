<?php
require_once 'salesinvoice_dd.php';
class salesinvoice extends data_abstraction
{
    var $fields = array();
    var $tables='salesinvoice';

    function salesinvoice()
    {
        $this->fields = salesinvoice_dd::load_dictionary();
        $this->relations = salesinvoice_dd::load_relationships();
        $this->subclasses = salesinvoice_dd::load_subclass_info();
    }

    function add($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('INSERT');
        $this->set_fields('id, Date, Status, Employee, SalesOrder_id, Customer_id');
        $this->set_values("'$id', '$Date', '$Status', '$Employee', '$SalesOrder_id', '$Customer_id'");
        $this->make_query(TRUE,$log_query);
    }

    function edit($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('UPDATE');
        $this->set_update("Date = '$Date', Status = '$Status', Employee = '$Employee', SalesOrder_id = '$SalesOrder_id', Customer_id = '$Customer_id'");
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
            $Date = str_replace('"',"''", $Date);
            $Status = str_replace('"',"''", $Status);
            $Employee = str_replace('"',"''", $Employee);
            $SalesOrder_id = str_replace('"',"''", $SalesOrder_id);
            $Customer_id = str_replace('"',"''", $Customer_id);

            $csv_contents .= '"' . $id . '","' . $Date . '","' . $Status . '","' . $Employee . '","' . $SalesOrder_id . '","' . $Customer_id . '"' . "\r\n";
        }

        return $csv_contents;
    }
}
