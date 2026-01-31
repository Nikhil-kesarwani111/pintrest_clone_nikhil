import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';
import '../provider/search_provider.dart';
import '../widget/pinterest_search_bar.dart';
import '../widget/recent_search_tile.dart';
import '../widget/search_results_body.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late TextEditingController _searchController;
  late FocusNode _focusNode;

  // View States
  bool _showResults = false; // True when user hits Enter
  List<String> _suggestions = []; // Auto-complete list

  // Mock Suggestions for "ave"
  final List<String> _allMockSuggestions = [
    "avengers", "aventurine", "avengers wallpaper", "averythemayo",
    "avenged sevenfold", "avengers wallpaper hd 4k", "avengers doomsday",
    "avery", "aventurine hsr"
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();

    // Listen to focus changes to update UI (hide search icon)
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // --- Actions ---

  void _onTextChanged(String query) {
    setState(() {
      _showResults = false; // Reset results if typing
      if (query.isNotEmpty) {
        // Filter mock suggestions
        _suggestions = _allMockSuggestions
            .where((s) => s.contains(query.toLowerCase()))
            .toList();
      } else {
        _suggestions = [];
      }
    });
  }

  void _onSubmit(String query) {
    if (query.trim().isEmpty) return;
    _focusNode.unfocus(); // Close keyboard

    // Add to history provider
    ref.read(recentSearchProvider.notifier).addSearch(
        query,
        "https://images.pexels.com/photos/301920/pexels-photo-301920.jpeg?auto=compress&cs=tinysrgb&w=200"
    );

    setState(() {
      _showResults = true; // Switch to Result View (Screenshot 4)
    });
  }

  void _onCancel() {
    if (_showResults) {
      // If in results, go back to search input
      setState(() {
        _showResults = false;
        _searchController.clear();
        _suggestions = [];
      });
      _focusNode.requestFocus(); // Bring back keyboard
    } else {
      // If in search input, just clear/unfocus
      _searchController.clear();
      _focusNode.unfocus();
      setState(() {
        _suggestions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final recentSearches = ref.watch(recentSearchProvider);
    final bool isTyping = _searchController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w(context), 12.h(context), 16.w(context), 4.h(context)),
              child: Row(
                children: [
                  //  Back Button
                  if (_showResults) ...[
                    GestureDetector(
                      onTap: _onCancel,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.w(context)),
                        child: Icon(Icons.chevron_left, size: 36.sp(context), color: AppColors.black),
                      ),
                    ),
                  ],

                  //  Search Bar

                  Expanded(
                    child: PinterestSearchBar(
                      controller: _searchController,
                      focusNode: _focusNode,
                      onChanged: _onTextChanged,
                      onSubmitted: _onSubmit,
                      // Pass the state here:
                      hideTrailingIcon: _showResults,

                      onClearTap: () {
                        _searchController.clear();
                        _onTextChanged("");
                      },
                      onCameraTap: () {},
                    ),
                  ),
                  // . Right Side Actions
                  if (!_showResults) ...[
                    SizedBox(width: 12.w(context)),
                    GestureDetector(
                      onTap: () {
                        _focusNode.unfocus();
                      },
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp(context),
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ] ,
                ],
              ),
            ),

            Expanded(
              child: Builder(
                builder: (context) {
                  // CASE 1: Show Results Grid
                  if (_showResults) {
                    return SearchResultsBody(query: _searchController.text);
                  }

                  // CASE 2: Show Autocomplete Suggestions (Screenshot 3)
                  if (isTyping && _suggestions.isNotEmpty) {
                    return ListView.builder(
                      itemCount: _suggestions.length,
                      padding: EdgeInsets.symmetric(vertical: 8.h(context)),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.search, size: 24.sp(context), color: Colors.black),
                          title: RichText(
                            text: TextSpan(
                              text: _suggestions[index].substring(0, _searchController.text.length),
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp(context),
                                fontWeight: FontWeight.bold, // Match typed text bold
                                color: AppColors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: _suggestions[index].substring(_searchController.text.length),
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp(context),
                                    fontWeight: FontWeight.bold, // Pinterest makes whole suggestion bold
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            _searchController.text = _suggestions[index];
                            _onSubmit(_suggestions[index]);
                          },
                        );
                      },
                    );
                  }

                  // CASE 3: Show Recent History (Screenshot 1)
                  return ListView.builder(
                    itemCount: recentSearches.length,
                    padding: EdgeInsets.only(top: 10.h(context)),
                    itemBuilder: (context, index) {
                      final item = recentSearches[index];
                      return RecentSearchTile(
                        item: item,
                        onTap: () {
                          _searchController.text = item.query;
                          _onSubmit(item.query);
                        },
                        onDelete: () {
                          ref.read(recentSearchProvider.notifier).removeSearch(item.id);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}