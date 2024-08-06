import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:volunteer_linker/core/enums.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../home_page/presentation/bloc/home_page_bloc.dart';
import '../../../home_page/presentation/widgets/custom_drawer.dart';
import '../../../home_page/presentation/widgets/opportunity_card.dart';
import '../../../opportunity/data/model/opportunity.dart';
import '../bloc/bloc/opportunity_attendance_bloc.dart';

class PostedOpportunities extends StatefulWidget {
  const PostedOpportunities({super.key});

  @override
  State<PostedOpportunities> createState() => _PostedOpportunitiesState();
}

class _PostedOpportunitiesState extends State<PostedOpportunities> {
  final PagingController<int, Opportunity> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _fetchPage(0);
  }

  void _fetchPage(int pageKey) {
    String uid = context.read<AuthBloc>().state.user?.uid ?? "";
    if (uid.isNotEmpty) {
      context.read<OpportunityAttendanceBloc>().add(
            FetchUserPostsEvent(
              state: context.read<OpportunityAttendanceBloc>().state,
              userId: uid,
            ),
          );
    }
  }

  Future<void> _refreshOpportunities() async {
    _fetchPage(0);
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _onItemTapped(CurrentPage currentPage, AuthState authState) {
    BlocProvider.of<AuthBloc>(context).add(
      ChangePageEvent(
        changePage: currentPage,
        state: authState,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return RefreshIndicator(
          onRefresh: _refreshOpportunities,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Posted opportunities'),
              centerTitle: true,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            drawer: CustomDrawer(
              authState: authState,
              onItemTapped: _onItemTapped,
            ),
            body: BlocBuilder<OpportunityAttendanceBloc,
                OpportunityAttendanceState>(
              builder: (context, state) {
                switch (state.status) {
                  case PostStatus.failure:
                    return const Center(child: Text('Failed to fetch posts'));
                  case PostStatus.success:
                    if (state.opportunities.isEmpty) {
                      return const Center(child: Text('You have no posts yet'));
                    }
                    _pagingController.value = PagingState(
                      itemList: state.opportunities,
                      error: null,
                      nextPageKey: state.hasReachedMax
                          ? null
                          : state.opportunities.length,
                    );
                    return PagedListView<int, Opportunity>(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Opportunity>(
                        itemBuilder: (context, item, index) => GestureDetector(
                          onTap: () {
                            BlocProvider.of<AuthBloc>(context).add(
                              ChangePageEvent(
                                changePage: CurrentPage.participants,
                                state: authState,
                                opportunityId: item.id ?? "",
                              ),
                            );

                            // Future.delayed(const Duration(milliseconds: 100),
                            //     () {
                            //   BlocProvider.of<AuthBloc>(context).add(
                            //     ToggleUserType(
                            //       userType: authState.userType ==
                            //               UserType.organization
                            //           ? UserType.volunteer
                            //           : UserType.organization,
                            //       state: authState,
                            //     ),
                            //   );
                            // });
                            // print("Tapped on item: ${item.id}");
                            // BlocProvider.of<AuthBloc>(context)
                            //     .add(SelectOpportunityId(
                            //   opportunityId: item.id ?? "",
                            //   state: authState,
                            // ));
                          },
                          child: OpportunityCard(
                            organizationName: item.organizationName,
                            createdAt: item.createdAt ?? DateTime.now(),
                            address: item.location.readableAddress,
                            imageUrl: item.imageUrl,
                            description: item.description,
                            organizationLogoUrl: item.organizationLogoUrl,
                            participants: (item.registeredUsers.length +
                                item.attendees.length),
                            onApply: () {},
                          ),
                        ),
                      ),
                    );
                  case PostStatus.initial:
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        );
      },
    );
  }
}
