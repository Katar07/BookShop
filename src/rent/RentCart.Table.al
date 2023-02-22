table 50361 "Rent Cart"
{
    Caption = 'Rent Cart';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "User Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
        }
        field(5; Default; Boolean)
        {
            Caption = 'Cart for checkout';
            trigger OnValidate()
            begin
                xRec.TestField(Default, false);
            end;
        }
        field(6; "Customer No"; Code[20])
        {
            Editable = false;
        }
        field(9; TotalQuantity; Decimal)
        {
            Caption = 'Total Quantity';
            Editable = false;
        }
        field(11; DueDate; Date)
        {
            Caption = 'Due Date';
        }
        field(12; "BackendCustomer No."; Code[20])
        {
            Editable = false;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        RentCart: Record "Rent Cart";
        UserLoginManagement: Codeunit "User Login Management";
    begin
        Rec."User Name" := UserLoginManagement.GetCurrentUserLogin()."User Name";
        Rec."Customer No" := UserLoginManagement.GetCurrentUserLogin()."Customer No.";
        Rec.Description := 'My cart';

        RentCart.SetRange("User Name", UserLoginManagement.GetCurrentUserLogin()."User Name");
        RentCart.SetFilter("No.", '<>%1', Rec."No.");
        if RentCart.IsEmpty() then
            Rec.Default := true;
    end;

    procedure FindMyDefault(): Boolean
    var
        UserLoginManagement: Codeunit "User Login Management";
    begin
        Rec.SetRange("User Name", UserLoginManagement.GetCurrentUserLogin()."User Name");
        Rec.SetRange(Default, true);
        exit(Rec.FindFirst());
    end;


    procedure TotalCartQuantity() TotalQt: Decimal
    var
        RentCartLine: Record "Rent Cart Line";
    begin
        RentCartLine.SetRange(RentCartLine."Rent Cart No.", "No.");
        RentCartLine.SetRange(RentCartLine."Rent Line No.");
        if RentCartLine.FindSet() then
            repeat
                TotalQt += RentCartLine.Quantity;

            until RentCartLine.Next() = 0;
        exit(TotalQt);
    end;

    procedure CreateNewNo(): Code[20]
    var
        RentCart: Record "Rent Cart";
    begin
        RentCart.LockTable();
        if RentCart.FindLast() then
            exit(IncStr(RentCart."No."))
        else
            exit('CART-01');
    end;
}
