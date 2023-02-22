pageextension 50353 "Item Ledger Entries Ext." extends "Item Ledger Entries"
{
    trigger OnOpenPage()
    var
        UserLoginManagement: Codeunit "User Login Management";

    begin
        Rec.SetRange("Entry Type", Rec."Entry Type"::Sale);
        Rec.SetRange("Source No.", UserLoginManagement.GetCurrentUserLogin()."Customer No.");
    end;
}
