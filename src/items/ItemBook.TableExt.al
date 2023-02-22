tableextension 50350 "ItemBook" extends Item
{
    fields
    {
        field(50350; "Book Category Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Book Category Name';
            TableRelation = "Item Book Category";
            trigger OnValidate()
            var
                BookCategoy: Record "Item Book Category";
            begin
                CheckItemCategoryCode();
                BookCategoy.Get(Rec."Book Category Name");
                Rec."Book Category Name" := BookCategoy."Category Name";
            end;
        }
        field(50351; Author; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = Author."No.";

            trigger OnValidate()
            var
                Author: Record Author;
            begin
                CheckItemCategoryCode();
                Author.Get(Rec.Author);
                Rec.Author := Author.Name;
            end;
        }
        field(50352; "Book Series Name"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Item Book Series"."No.";
            trigger OnValidate()
            var
                BookSeries: Record "Item Book Series";
            begin
                CheckItemCategoryCode();
                BookSeries.Get(Rec."Book Series Name");
                Rec."Book Series Name" := BookSeries."Book Series Name";
                Rec."Book Series No." := BookSeries."No.";
            end;
        }
        field(50353; Preview; Blob)
        {
            DataClassification = CustomerContent;
        }
        field(50354; "Cart Filter"; Code[20])
        {
            Caption = 'Cart Filter';
            FieldClass = FlowFilter;
            TableRelation = Cart."No." where("User Name" = field("User Filter"), Default = const(true));
        }
        field(50355; "User Filter"; Code[20])
        {
            Caption = 'User Filter';
            FieldClass = FlowFilter;
            TableRelation = "UserLogin"."User Name";
        }
        field(50356; "Backend BookItem ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50357; "Book Series No."; Integer)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()

            begin
                Rec.Validate("Book Series Name");
            end;
        }
    }

    local procedure CheckItemCategoryCode(): Text
    var
        ErrTxt: Label 'To fill this filed Item category code must be "Books"';
    begin
        Rec.SetRange("Item Category Code");
        Rec.TestField("Item Category Code", 'BOOKS');
        exit(ErrTxt);
    end;

    procedure SetPreview(NewPreview: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Preview");
        "Preview".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewPreview);
        Modify();
    end;

    procedure GetPreview() BookPreview: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
        PreviewErrTxt: Label 'Cannot read field %1 ', Comment = '%1=field caption';
    begin
        CalcFields("Preview");
        "Preview".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), BookPreview) then
            Message(PreviewErrTxt, FieldCaption("Preview"));
    end;

}
