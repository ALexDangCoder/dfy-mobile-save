import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';

class OnBoardingContent {
  final String image;
  final String title;
  final String descriptionNormal;
  final String descriptionYellow;
  String? partDescription; //for step 4 because yellow text in middle

  OnBoardingContent({
    required this.image,
    required this.title,
    required this.descriptionNormal,
    required this.descriptionYellow,
    this.partDescription,
  });
}

List<OnBoardingContent> contents = [
  OnBoardingContent(
    title: '${S.current.step} 1',
    image: ImageAssets.content1,
    descriptionNormal: S.current.create_an_unauth_hard_nft,
    descriptionYellow: 'hard NFT',
  ),
  OnBoardingContent(
    title: '${S.current.step} 2',
    image: ImageAssets.content2,
    descriptionYellow: S.current.send_evalue_to_evaluator,
    descriptionNormal: S.current.to_evaluator,
  ),
  OnBoardingContent(
    title: '${S.current.step} 3',
    image: ImageAssets.content3,
    descriptionYellow: S.current.receive_accept_result_blockchain,
    descriptionNormal: S.current.on_blockchain,
  ),
  OnBoardingContent(
    title: '${S.current.step} 4',
    image: ImageAssets.content4,
    descriptionNormal: S.current.put_hard_nft_market,
    partDescription: S.current.to_take_profit,
    descriptionYellow: S.current.marketplace,
  ),
];
