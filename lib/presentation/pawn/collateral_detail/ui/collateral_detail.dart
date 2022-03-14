import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/pawn/detail_collateral.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_detail/bloc/collateral_detail_bloc.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollateralDetailScreen extends StatefulWidget {
  final String id;

  const CollateralDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _CollateralDetailScreenState createState() => _CollateralDetailScreenState();
}

class _CollateralDetailScreenState extends State<CollateralDetailScreen> {
  late CollateralDetailBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CollateralDetailBloc(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: S.current.collateral_detail,
      isImage: true,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          spaceH8,
          Padding(
            padding: EdgeInsets.all(16.w),
            child: StreamBuilder<CollateralDetail>(
              stream: bloc.objCollateral,
              builder: (context, snapshot) {
                final obj = snapshot.data ?? CollateralDetail();
                return Column(
                  children: [
                    Text(
                      S.current.collateral_of_bda,
                      style: textNormalCustom(
                        null,
                        20,
                        FontWeight.w700,
                      ),
                    ),
                    spaceH8,
                  ],
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              // if (snapshot.data ?? false) {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (context) => EvaluationResult(
              //         assetID: widget.assetId,
              //         pageRouter: widget.pageRouter,
              //       ),
              //       settings: const RouteSettings(
              //         name: AppRouter.step3ListEvaluation,
              //       ),
              //     ),
              //   );
              // }
            },
            child: SizedBox(
              width: 160.w,
              child: ButtonGold(
                haveMargin: false,
                fixSize: false,
                isEnable: true,
                title: S.current.view_evaluation,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
