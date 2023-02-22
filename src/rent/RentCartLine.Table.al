table 50362 "Rent Cart Line"
{
    Caption = 'Rent Cart Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Rent Cart No."; Code[20])
        {
            Caption = 'Cart No.';
            TableRelation = "Rent Cart"."No.";
        }
        field(2; "Rent Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No." where("Item Category Code" = const('BOOKS'));

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                Item.Get(Rec."Item No.");
                Rec.Validate(Description, Item.Description);
                Rec.Validate(Quantity, 1);
            end;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            trigger OnValidate()
            begin
                If Rec.Quantity <= 0 then
                    Error('Quantity must be 1 or more!');
            end;
        }
        field(5; RentUnitPrice; Decimal)
        {
            Caption = 'Rent Unit Price';
            DataClassification = AccountData;
            Editable = false;

        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "Flow Description"; Text[100])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }
    }
    keys
    {
        key(PK; "Rent Cart No.", "Rent Line No.")
        {
            Clustered = true;
        }
    }
}
