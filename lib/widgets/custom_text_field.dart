import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moderation_tool/blocs/custom_text_field_bloc.dart';
import 'package:moderation_tool/utilites/prepare.dart';


class CustomTextField extends StatefulWidget {
  final TextEditingController _textController;
  final String hintText;
  final String lableText;
  int maxLines;
  final TextInputType textInputType;
  final IconData icon;
  IconButton suffixIcon;
  bool autoValidate;
  bool enablePasswordText;
  bool animation;
  final String helperText;
  final Function validatorFunction;
  final Function onChangedFunction;
  final Function onSavedFunction;
  bool autofocus;
  bool enableReadOnly;
  bool customEnableEditing;
  final Function onEditingCompleteFunction;
  final Function onTextSubmittedFunction;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function onFocusScopeChanged;

  List<TextInputFormatter> inputFormatters;
  CustomTextField({
    Key key,
    @required TextEditingController textController,
    this.textInputAction,
    this.focusNode,
    this.enableReadOnly,
    this.lableText,
    this.autofocus,
    this.inputFormatters,
    this.icon,
    this.suffixIcon,
    this.hintText,
    this.maxLines,
    this.textInputType,
    this.animation,
    this.enablePasswordText,
    this.validatorFunction,
    this.autoValidate,
    this.onChangedFunction,
    this.onSavedFunction,
    this.onTextSubmittedFunction,
    this.onEditingCompleteFunction,
    this.onFocusScopeChanged,
    this.helperText,
    this.customEnableEditing,
  })  : _textController = textController,
        super(key: key) {
/////////
    autoValidate = autoValidate == null ? false : autoValidate;
    enablePasswordText =
        (enablePasswordText == null) ? false : enablePasswordText;
    customEnableEditing=customEnableEditing??false;
    print(" textField => ${lableText} = ${enablePasswordText}");
    maxLines = (enablePasswordText) ? 1 : maxLines;
    /////////
    inputFormatters = inputFormatters == null ? List() : inputFormatters;
    autofocus = (autofocus == null) ? false : autofocus;
    enableReadOnly=enableReadOnly??false;
  }

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  CustomTextFieldBloc _customTextFieldBloc;
  AnimationController _controllerTextField;
  Animation _animationTextField;

  Prepare _prepare;
  @override
  void initState() {
    _prepare = Prepare();
    _customTextFieldBloc = CustomTextFieldBloc();

    _controllerTextField = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    checkAnimation();
    _controllerTextField.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controllerTextField?.dispose();
    _customTextFieldBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("autodoucas = ${widget.autofocus}");
    return StreamBuilder(
        stream: _customTextFieldBloc.scPasswordVisabilityStream,
        builder: (context, AsyncSnapshot snapshot) {
          print("from run visability ${snapshot.connectionState}");
          
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.active:
              print("snapshot test ${snapshot.data}");
              return SlideTransition(
                position: _animationTextField,
                child: FocusScope(
                  child: Focus(
                    /*
                      _customTextFieldBloc
                                      .scChangePasswordVisabilitySink
                                      .add(snapshot.data);

                     */
                    onFocusChange: widget.onFocusScopeChanged==null?(widget.enablePasswordText||widget.customEnableEditing)
                        ? (focus) => (focus
                            ? null
                            : _customTextFieldBloc
                                .scChangePasswordVisabilitySink
                                .add(false))//if selected textfield is password field then after un foucuse it, must be sink false in stream to insure that field is obsecure
                        : null:widget.onFocusScopeChanged,
                    child: TextFormField(
                      focusNode: widget.focusNode,
                      onFieldSubmitted: widget.onTextSubmittedFunction,
                      autofocus: widget.autofocus,
                      onChanged: widget.onChangedFunction,
                      onSaved: widget.onSavedFunction,
                      onEditingComplete: (widget.enablePasswordText)
                          ? () {
                              print("from here");
                              _customTextFieldBloc
                                  .scChangePasswordVisabilitySink
                                  .add(false);
                            }
                          : widget.onEditingCompleteFunction,
                      autovalidate: widget.autoValidate,
                      obscureText: (widget.enablePasswordText)
                          ? snapshot.data
                          : widget
                              .enablePasswordText, //youshould make maxline = 1 or delete this property to make field is obscureText
                      controller: widget._textController,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        cut: true,
                        paste: true,
                        selectAll: true,
                      ),
                      inputFormatters: widget
                          .inputFormatters, //<TextInputFormatter>[WhitelistingTextInputFormatter(RegExp('[0-9]')),]
                      textInputAction: widget.textInputAction,
                      keyboardType: widget.textInputType,
                      maxLines: widget.maxLines,
                      readOnly: widget.customEnableEditing?snapshot.data:widget.enableReadOnly,
                      decoration: InputDecoration(     
                        suffixIcon: (widget.enablePasswordText)
                            ? IconButton(
                                icon: Icon((snapshot.data)
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  _customTextFieldBloc
                                      .scChangePasswordVisabilitySink
                                      .add(snapshot.data);
                                })
                            : widget.customEnableEditing?IconButton(icon: Icon(Icons.edit),onPressed:(){
                               _customTextFieldBloc/***************************/
                                      .scChangePasswordVisabilitySink
                                      .add(snapshot.data);
                            }):widget.suffixIcon,
                        helperText: widget.helperText,
                        prefixIcon: Icon(
                          widget.icon,
                          color: Theme.of(context).primaryColor,
                        ),
                        labelText: widget.lableText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.08),
                        ),
                        hintText: widget.hintText,
                      ),
                      validator: widget.validatorFunction,
                    ),
                  ),
                ),
              );
              break;
            default:
              return CircularProgressIndicator();
          }
        });
  }

  checkAnimation() {
    widget.animation = widget.animation == null ? false : widget.animation;

    (widget.animation)
        ? _animationTextField = Tween<Offset>(
                begin: Offset(_prepare.checkLangDirection * 1, 0),
                end: Offset(0, 0))
            .animate(_controllerTextField)
        : _animationTextField =
            Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 0))
                .animate(_controllerTextField);
  }
}
