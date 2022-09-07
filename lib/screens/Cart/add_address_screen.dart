import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gnon/constants/widget.dart';
import 'package:gnon/screens/Cart/address_bloc/address_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../constants/color_constans.dart';
import '../../constants/themes.dart';
import '../../localization/localization_constants.dart';
import '../../models/countries_model.dart';
import '../../models/order_data_model.dart';
import '../../sharedPreferences.dart';

class AddAddressScreen extends StatefulWidget {
   AddAddressScreen(this.lang,
   this.orderData,
       {Key? key,this.withFloatingActionButton}) : super(key: key);
   bool? withFloatingActionButton=true;
  String? lang;
   OrderData? orderData;
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCountry;
  int? selectedCountryId;
  int? selectedCity;
  int? selectedRegion;

  TextEditingController addressEditingController=TextEditingController();

  TextEditingController postalCodeEditingController=TextEditingController();
  TextEditingController phoneEditingController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AddressCubit()..getAddressData(widget.lang),
  child: BlocConsumer<AddressCubit, AddressState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
   /* var countriesModel=AddressCubit.get(context).countriesModel;
    var governoratesModel=AddressCubit.get(context).governoratesModel;
    var cityModel=AddressCubit.get(context).cityModel;*/
    List<String> address=[
      "cairo",
      "masr",
      "vddvedeg",
      "ghyjk",
      "ukukuk",
      "juykutk",
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:
        Icon(Icons.arrow_back_ios,size: 14,color: HexColor("#9098B1"),)),
        title: customText(
            getTranslated(context,"Add Address",)!
            ,fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
      /*state is GetLoadingCreateAddressState?
      const SpinKitChasingDots(
        color: customColor,
        size: 40,
      ):*/
      customFloatingActionButton(context,
          color: HexColor("#BA6400")
          ,onPress: (){
        if (_formKey.currentState!.validate()) {
    MySharedPreferences().getUserId().then((value) {
         /*AddressCubit.get(context).createAddress(
           value,
             selectedCountryId,
           selectedRegion,
           selectedCity,
          addressEditingController.text,
          postalCodeEditingController.text,
          phoneEditingController.text,
           context,
           widget.withFloatingActionButton,
           widget.orderData
         );*/
        });
        }
      },text:
      getTranslated(context,"Save Address",)!
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                    getTranslated(context,"Country or region",)!
                    ,
                    fontWeight: FontWeight.w600),
                const SizedBox(height: 10),
                /*countriesModel==null?
                const Center(
                  child:  SpinKitChasingDots(
                    color: customColor,
                    size: 40,
                  ),
                ):*/
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  isExpanded: true,
                  hint:  Text(
                    getTranslated(context,"Select Your Country or region",)!
                    ,
                    style: const TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 50,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: address.map((item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return getTranslated(context,"Please select Country.",)!;
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    /*selectedCountry = value.toString();
                    selectedCountryId = value!.id;
                    AddressCubit.get(context).getGovernorates(
                        Localizations.localeOf(context).languageCode
                        , value.id);*/
                  },
                  onSaved: (String? value) {

                  },
                ),


              /*  const SizedBox(height: 15),

                TextFormField(
                 decoration:  InputDecoration(
                     labelStyle:  const TextStyle(fontSize: 12),
                   labelText: getTranslated(context,"First Name",)!,
                   contentPadding:  const EdgeInsets.all(10),
                   border:  const OutlineInputBorder()
                 ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context,"Please Enter First Name",)!;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                TextFormField(
                  decoration:  InputDecoration(
                      labelStyle:  const TextStyle(fontSize: 12),
                      labelText: getTranslated(context,"Last Name",)!
                      ,
                      contentPadding: const EdgeInsets.all(10),
                      border:  const OutlineInputBorder()
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context,"Please Enter Last Name.",)!;
                    }
                    return null;
                  },
                ),*/

                const SizedBox(height: 15),
                customText(
                    getTranslated(context,"Street Address",)!
                    ,
                    fontWeight: FontWeight.w600),
                const SizedBox(height: 10),
                TextFormField(
                  controller: addressEditingController,
                  decoration:  InputDecoration(
                      /*labelText: getTranslated(context,"Street Address",)!
                      ,*/
                      labelStyle:  const TextStyle(fontSize: 12),
                      contentPadding:  const EdgeInsets.all(10),
                      border:  const OutlineInputBorder()
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context,"Please Enter Street Address.",)!
                      ;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                customText(
                    getTranslated(context,"Postal Code",)!
                    ,
                    fontWeight: FontWeight.w600),
                const SizedBox(height: 10),
                TextFormField(
                  controller: postalCodeEditingController,
                  decoration:  InputDecoration(
                      labelStyle:  const TextStyle(fontSize: 12),
                      /*labelText: getTranslated(context,"Postal Code",)!
                      ,*/
                      contentPadding: const EdgeInsets.all(10),
                      border:  const OutlineInputBorder()
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context,"Please Enter Postal Code.",)!
                        ;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                customText(
                    getTranslated(context,"Phone Number",)!
                    ,
                    fontWeight: FontWeight.w600),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneEditingController,
                  decoration:  InputDecoration(
                      labelStyle:  const TextStyle(fontSize: 12),
                      /*labelText: getTranslated(context, "Phone Number",)!
                      ,*/
                      contentPadding: const EdgeInsets.all(10),
                      border:  const OutlineInputBorder()
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, "Please Enter Street Address2.",)!
                      ;
                    }
                    return null;
                  },
                ),
                customText(
                    getTranslated(context, "State/Province/Region",)!
                    ,fontWeight: FontWeight.w600),
                const SizedBox(height: 10),

                /*governoratesModel==null?
                Container():
                state is GetLoadingGovernoratesAddressState?
                const Center(
                  child:  SpinKitChasingDots(
                    color: customColor,
                    size: 40,
                  ),
                ):*/
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Select Your Region',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 50,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: address.
                  map((item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item/*.name??""*/,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select Region';
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                   /* print(value!.name);
                    AddressCubit.get(context).getCity(
                        Localizations.localeOf(context).languageCode
                        , selectedCountryId
                        ,value.id);
                    selectedRegion = value.id;*/
                  },
                  onSaved: (String? value) {

                  },
                ),
                const SizedBox(height: 15),


                customText(
                    getTranslated(context,"City",)!
                    ,
                    fontWeight: FontWeight.w600),
                const SizedBox(height: 10),

                /*cityModel==null?
                Container():
                state is GetLoadingCityAddressState?
                const Center(
                  child:  SpinKitChasingDots(
                    color: customColor,
                    size: 40,
                  ),
                ):*/
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  isExpanded: true,
                  hint:  Text(
                    getTranslated(context,"Select Your City",)!
                    ,
                    style: const TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 50,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: address.map((item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return getTranslated(context,"Please select City.",)!
                      ;
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                   /* selectedCity = value!.id;*/
                  },
                  onSaved: (value) {
                  },
                ),




                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  },
),
);
  }
}
