import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifly_corporate_app/bloc/authentication/authentication_bloc.dart';
import 'package:ifly_corporate_app/bloc/corporate_auth/corporate_bloc.dart';
import 'package:ifly_corporate_app/data/repositories/corporate_repository.dart';
import 'package:ifly_corporate_app/presentation/pages/corporate_selection/widgets/corporate_error_card.dart';
import 'package:ifly_corporate_app/presentation/pages/corporate_selection/widgets/corporate_form.dart';
import 'package:ifly_corporate_app/presentation/utils/scaffold_body.dart';

class CorporateSelectionPage extends StatefulWidget {
  const CorporateSelectionPage({
    @required this.corporateRepository,
    Key key,
  })  : assert(corporateRepository != null),
        super(key: key);
  final CorporateRepository corporateRepository;
  @override
  _CorporateSelectionPageState createState() => _CorporateSelectionPageState();
}

class _CorporateSelectionPageState extends State<CorporateSelectionPage> {
  final _animatedSwitcherKey = ValueKey('_animated_switcher_key_');
  Widget _errorCardForState(CorporateAuthState state) {
    if (state is CorporatAuthFailed) {
      return CorporateErrorCard();
    } else if (state is CorporateAuthOnEdit) {
      return const SizedBox();
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocProvider<CorporateAuthBloc>(
      create: (context) => CorporateAuthBloc(
          corporateRepository: widget.corporateRepository,
          authenticationBloc: authBloc),
      child: Scaffold(
        body: BlocBuilder<CorporateAuthBloc, CorporateAuthState>(
          builder: (context, state) {
            return ScaffoldBody.authSceneNormal(
                child: ListView(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 2.60,
                ),
                AspectRatio(
                  aspectRatio: 4.0,
                  child: SvgPicture.asset(
                    'assets/images/logo-ifly.svg',
                  ),
                ),
                AspectRatio(
                  aspectRatio: 6,
                ),
                AnimatedSwitcher(
                  key: _animatedSwitcherKey,
                  duration: Duration(milliseconds: 250),
                  child: _errorCardForState(state),
                ),
                CorporateForm(
                  errorfunction: (bool flag) {},
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}
