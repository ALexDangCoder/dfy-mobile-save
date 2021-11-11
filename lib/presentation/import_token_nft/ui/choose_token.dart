import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_nft_bloc.dart';
import 'package:Dfy/widgets/form/form_search.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class ChooseToken extends StatelessWidget {
  final ImportTokenNftBloc bloc;

  const ChooseToken({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff3e3d5c),
      child: Column(
        children: [
          spaceH12,
          FormSearch(
            hint: Strings.token_search,
            bloc: bloc,
            urlIcon1: url_ic_search,
          ),
          spaceH12,
          line,
          spaceH24,
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    final FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: SizedBox(
                    height: 73,
                    width: 322,
                    child: ListTileSwitch(
                      switchScale: 1,
                      value: true,
                      leading: Image.asset('assets/images/Ellipse 39.png'),
                      onChanged: (value) {},
                      switchActiveColor: const Color(0xffE4AC1A),
                      switchType: SwitchType.cupertino,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Bitcoin',
                            style: textNormalCustom(
                                Colors.white, 16, FontWeight.w600,),
                          ),
                          spaceW6,
                          Text(
                            'BTC',
                            style: textNormalCustom(
                                const Color.fromRGBO(255, 255, 255, 0.7),
                                18,
                                FontWeight.w400,),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        '0.612,54 BTC',
                        style: textNormalCustom(
                            const Color.fromRGBO(255, 255, 255, 0.5),
                            16,
                            FontWeight.w400,),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
