table 50359 "Web Service Task"
{
    Caption = 'WebServiceTask';
    DataClassification = CustomerContent;

    fields
    {
        field(1; EntryNo; Integer)
        {
            Caption = 'EntryNo';
            AutoIncrement = true;

        }
        field(2; "Task Name"; Text[50])
        {
            Caption = 'Task Name';

        }
        field(3; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';

        }
        field(4; "Request Body"; Blob)
        {
            Caption = 'Request Body';

        }
        field(5; "Response Body"; Blob)
        {
            Caption = 'Response Body';

        }
        field(6; Status; Text[250])
        {
            Caption = 'Status';

        }
    }
    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }
    }

    procedure CreateNewTask(Name: Text[50]; PrimaryKey: Code[20])
    var
        WebServiceTask: Record "Web Service Task";
    begin
        WebServiceTask.SetRange("Primary Key", PrimaryKey);
        WebServiceTask.SetFilter(Status, '''''');
        if not WebServiceTask.IsEmpty then
            exit;
        Rec.Init();
        Rec."Task Name" := Name;
        Rec."Primary Key" := PrimaryKey;
        Rec.Insert(true)
    end;
}
