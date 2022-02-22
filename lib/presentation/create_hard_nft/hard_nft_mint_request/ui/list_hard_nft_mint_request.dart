import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/hard_nft_mint_request/bloc/hard_nft_mint_request_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/hard_nft_mint_request/ui/list_mint_request.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ListHardNftMintRequest extends StatefulWidget {
  const ListHardNftMintRequest({Key? key}) : super(key: key);

  @override
  _ListHardNftMintRequestState createState() => _ListHardNftMintRequestState();
}

class _ListHardNftMintRequestState extends State<ListHardNftMintRequest> {
  late HardNftMintRequestCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = HardNftMintRequestCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HardNftMintRequestCubit,HardNftMintRequestState>(
      bloc: cubit,
      builder: (BuildContext context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException(S.current.error, S.current.something_went_wrong),
          retry: () async {},
          textEmpty: '',
          child: content(state),
        );
      },
    );
  }

  Widget content(HardNftMintRequestState state) {
    return BaseDesignScreen(
      title: '',
      isImage: true,
      text: ImageAssets.ic_filter,
      onRightClick: () {},
      child: ListMintRequest(
        cubit: cubit,
        listMintRequest: const [],
      ),
    );
  }
}
