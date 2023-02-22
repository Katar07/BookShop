table 50350 "Author"
{
    Caption = 'Author';
    DataClassification = CustomerContent;
    LookupPageId = "AuthorList";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No';
            AutoIncrement = true;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "No of Books"; Integer)
        {
            Caption = 'No of Books';
        }
        field(4; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Name") { }
    }










    // trigger OnInsert()
    // var
    //     IsHandled: Boolean;
    // begin
    //     IsHandled := false;
    //     OnBeforeOnInsert(Rec, xRec, IsHandled);
    //     if IsHandled then
    //         exit;

    //     AuthorSetup.Get();
    //     if "No." = '' then begin
    //         AuthorSetup.TestField("Author No. Series");
    //         NoSeriesMgt.InitSeries(AuthorSetup."Author No. Series", xRec."No. Series", 0D, "No.", "No. Series");
    //     end;
    // end;

    // procedure AssistEdit() Result: Boolean
    // var
    //     IsHandled: Boolean;
    // begin
    //     OnBeforeAssistEdit(Rec, xRec, Result, IsHandled);
    //     if IsHandled then
    //         exit(Result);

    //     AuthorSetup.Get();
    //     AuthorSetup.TestField("Author No. Series");
    //     if NoSeriesMgt.SelectSeries(AuthorSetup."Author No. Series", xRec."No. Series", "No. Series") then begin
    //         NoSeriesMgt.SetSeries("No.");
    //         exit(true);
    //     end;
    // end;

    // var
    //     AuthorSetup: Record "Author Setup";
    //     NoSeriesMgt: Codeunit NoSeriesManagement;


    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeAssistEdit(var Author: Record Author; xAuthor: Record Author; var Result: Boolean; var IsHandled: Boolean)
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeOnInsert(var Author: Record Author; xAuthor: Record Author; var IsHandled: Boolean)
    // begin
    // end;



}
