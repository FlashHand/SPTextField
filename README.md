# SPTextField
```
UITextField *accountField=[SPTextField spTextFieldWithWidth:200 placeholder:@"手机号码" delegate:self];
[accountField.textField setDelegate:self];
[accountField setRegexStr:@"^((1[3-9]))\\d{9}$"];
[accountField.defaultSeparator setHidden:NO];
[accountField setBlankErrStr:@"请输入手机号码"];
[accountField setFormatErrStr:@"请输入正确的手机号码"];
[accountField setFrame:CGRectMake(0, 20, accountField.frame.size.width, accountField.frame.size.width)];
[self.view addSubview:accountField];
```
