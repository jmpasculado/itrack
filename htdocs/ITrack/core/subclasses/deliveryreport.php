<?php
require_once 'deliveryreport_dd.php';
class deliveryreport extends data_abstraction
{
    var $fields = array();
    var $tables='deliveryreport';

    function deliveryreport()
    {
        $this->fields = deliveryreport_dd::load_dictionary();
        $this->relations = deliveryreport_dd::load_relationships();
        $this->subclasses = deliveryreport_dd::load_subclass_info();
    }

    function add($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('INSERT');
        $this->set_fields('id, Date, Employee, AuthPerson, Status, Remarks, Purchaseorder_id');
        $this->set_values("'$id', '$Date', '$Employee', '$AuthPerson', '$Status', '$Remarks', '$Purchaseorder_id'");
        $this->make_query(TRUE,$log_query);
    }

    function edit($param, $log_query=TRUE)
    {
        $this->escape_arguments($param);
        extract($param);
        $this->set_query_type('UPDATE');
        $this->set_update("Date = '$Date', Employee = '$Employee', AuthPerson = '$AuthPerson', Status = '$Status', Remarks = '$Remarks', Purchaseorder_id = '$Purchaseorder_id'");
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
            $Employee = str_replace('"',"''", $Employee);
            $AuthPerson = str_replace('"',"''", $AuthPerson);
            $Status = str_replace('"',"''", $Status);
            $Remarks = str_replace('"',"''", $Remarks);
            $Purchaseorder_id = str_replace('"',"''", $Purchaseorder_id);

            $csv_contents .= '"' . $id . '","' . $Date . '","' . $Employee . '","' . $AuthPerson . '","' . $Status . '","' . $Remarks . '","' . $Purchaseorder_id . '"' . "\r\n";
        }

        return $csv_contents;
    }
}
