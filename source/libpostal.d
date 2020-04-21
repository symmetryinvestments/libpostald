module libpostalbinding;


        import core.stdc.config;
        import core.stdc.stdarg: va_list;
        static import core.simd;
        static import std.conv;

        struct Int128 { long lower; long upper; }
        struct UInt128 { ulong lower; ulong upper; }

        struct __locale_data { int dummy; }



alias _Bool = bool;
struct dpp {
    static struct Opaque(int N) {
        void[N] bytes;
    }

    static bool isEmpty(T)() {
        return T.tupleof.length == 0;
    }
    static struct Move(T) {
        T* ptr;
    }


    static auto move(T)(ref T value) {
        return Move!T(&value);
    }
    mixin template EnumD(string name, T, string prefix) if(is(T == enum)) {
        private static string _memberMixinStr(string member) {
            import std.conv: text;
            import std.array: replace;
            return text(` `, member.replace(prefix, ""), ` = `, T.stringof, `.`, member, `,`);
        }
        private static string _enumMixinStr() {
            import std.array: join;
            string[] ret;
            ret ~= "enum " ~ name ~ "{";
            static foreach(member; __traits(allMembers, T)) {
                ret ~= _memberMixinStr(member);
            }
            ret ~= "}";
            return ret.join("\n");
        }
        mixin(_enumMixinStr());
    }
}

extern(C)
{
    alias wchar_t = int;
    alias size_t = c_ulong;
    alias fsfilcnt_t = c_ulong;
    alias fsblkcnt_t = c_ulong;
    alias blkcnt_t = c_long;
    alias blksize_t = c_long;
    alias register_t = c_long;
    alias u_int64_t = c_ulong;
    alias u_int32_t = uint;
    alias u_int16_t = ushort;
    alias u_int8_t = ubyte;
    alias key_t = int;
    alias caddr_t = char*;
    alias daddr_t = int;
    alias id_t = uint;
    alias pid_t = int;
    alias uid_t = uint;
    alias nlink_t = c_ulong;
    alias mode_t = uint;
    alias gid_t = uint;
    alias dev_t = c_ulong;
    alias ino_t = c_ulong;
    alias loff_t = c_long;
    alias fsid_t = __fsid_t;
    alias u_quad_t = c_ulong;
    alias quad_t = c_long;
    alias u_long = c_ulong;
    alias u_int = uint;
    alias u_short = ushort;
    alias u_char = ubyte;
    int pselect(int, fd_set*, fd_set*, fd_set*, const(timespec)*, const(__sigset_t)*) @nogc nothrow;
    int select(int, fd_set*, fd_set*, fd_set*, timeval*) @nogc nothrow;
    alias fd_mask = c_long;
    struct fd_set
    {
        c_long[16] __fds_bits;
    }
    alias __fd_mask = c_long;
    alias suseconds_t = c_long;
    int getloadavg(double*, int) @nogc nothrow;
    int getsubopt(char**, char**, char**) @nogc nothrow;
    int rpmatch(const(char)*) @nogc nothrow;
    c_ulong wcstombs(char*, const(int)*, c_ulong) @nogc nothrow;
    c_ulong mbstowcs(int*, const(char)*, c_ulong) @nogc nothrow;
    int wctomb(char*, int) @nogc nothrow;
    int mbtowc(int*, const(char)*, c_ulong) @nogc nothrow;
    int mblen(const(char)*, c_ulong) @nogc nothrow;
    int qfcvt_r(real, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int qecvt_r(real, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int fcvt_r(double, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int ecvt_r(double, int, int*, int*, char*, c_ulong) @nogc nothrow;
    char* qgcvt(real, int, char*) @nogc nothrow;
    char* qfcvt(real, int, int*, int*) @nogc nothrow;
    char* qecvt(real, int, int*, int*) @nogc nothrow;
    char* gcvt(double, int, char*) @nogc nothrow;
    char* fcvt(double, int, int*, int*) @nogc nothrow;
    char* ecvt(double, int, int*, int*) @nogc nothrow;
    lldiv_t lldiv(long, long) @nogc nothrow;
    ldiv_t ldiv(c_long, c_long) @nogc nothrow;
    div_t div(int, int) @nogc nothrow;
    long llabs(long) @nogc nothrow;
    c_long labs(c_long) @nogc nothrow;
    int abs(int) @nogc nothrow;
    void qsort(void*, c_ulong, c_ulong, int function(const(void)*, const(void)*)) @nogc nothrow;
    void* bsearch(const(void)*, const(void)*, c_ulong, c_ulong, int function(const(void)*, const(void)*)) @nogc nothrow;
    alias __compar_fn_t = int function(const(void)*, const(void)*);
    char* realpath(const(char)*, char*) @nogc nothrow;
    int system(const(char)*) @nogc nothrow;
    char* mkdtemp(char*) @nogc nothrow;
    int mkstemps(char*, int) @nogc nothrow;
    int mkstemp(char*) @nogc nothrow;
    char* mktemp(char*) @nogc nothrow;
    int clearenv() @nogc nothrow;
    int unsetenv(const(char)*) @nogc nothrow;
    int setenv(const(char)*, const(char)*, int) @nogc nothrow;
    int putenv(char*) @nogc nothrow;
    char* getenv(const(char)*) @nogc nothrow;
    void _Exit(int) @nogc nothrow;
    void quick_exit(int) @nogc nothrow;
    void exit(int) @nogc nothrow;
    int on_exit(void function(int, void*), void*) @nogc nothrow;
    int at_quick_exit(void function()) @nogc nothrow;
    int atexit(void function()) @nogc nothrow;
    void abort() @nogc nothrow;
    void* aligned_alloc(c_ulong, c_ulong) @nogc nothrow;
    int posix_memalign(void**, c_ulong, c_ulong) @nogc nothrow;
    alias libpostal_token_type_t = _Anonymous_0;
    enum _Anonymous_0
    {
        LIBPOSTAL_TOKEN_TYPE_END = 0,
        LIBPOSTAL_TOKEN_TYPE_WORD = 1,
        LIBPOSTAL_TOKEN_TYPE_ABBREVIATION = 2,
        LIBPOSTAL_TOKEN_TYPE_IDEOGRAPHIC_CHAR = 3,
        LIBPOSTAL_TOKEN_TYPE_HANGUL_SYLLABLE = 4,
        LIBPOSTAL_TOKEN_TYPE_ACRONYM = 5,
        LIBPOSTAL_TOKEN_TYPE_PHRASE = 10,
        LIBPOSTAL_TOKEN_TYPE_EMAIL = 20,
        LIBPOSTAL_TOKEN_TYPE_URL = 21,
        LIBPOSTAL_TOKEN_TYPE_US_PHONE = 22,
        LIBPOSTAL_TOKEN_TYPE_INTL_PHONE = 23,
        LIBPOSTAL_TOKEN_TYPE_NUMERIC = 50,
        LIBPOSTAL_TOKEN_TYPE_ORDINAL = 51,
        LIBPOSTAL_TOKEN_TYPE_ROMAN_NUMERAL = 52,
        LIBPOSTAL_TOKEN_TYPE_IDEOGRAPHIC_NUMBER = 53,
        LIBPOSTAL_TOKEN_TYPE_PERIOD = 100,
        LIBPOSTAL_TOKEN_TYPE_EXCLAMATION = 101,
        LIBPOSTAL_TOKEN_TYPE_QUESTION_MARK = 102,
        LIBPOSTAL_TOKEN_TYPE_COMMA = 103,
        LIBPOSTAL_TOKEN_TYPE_COLON = 104,
        LIBPOSTAL_TOKEN_TYPE_SEMICOLON = 105,
        LIBPOSTAL_TOKEN_TYPE_PLUS = 106,
        LIBPOSTAL_TOKEN_TYPE_AMPERSAND = 107,
        LIBPOSTAL_TOKEN_TYPE_AT_SIGN = 108,
        LIBPOSTAL_TOKEN_TYPE_POUND = 109,
        LIBPOSTAL_TOKEN_TYPE_ELLIPSIS = 110,
        LIBPOSTAL_TOKEN_TYPE_DASH = 111,
        LIBPOSTAL_TOKEN_TYPE_BREAKING_DASH = 112,
        LIBPOSTAL_TOKEN_TYPE_HYPHEN = 113,
        LIBPOSTAL_TOKEN_TYPE_PUNCT_OPEN = 114,
        LIBPOSTAL_TOKEN_TYPE_PUNCT_CLOSE = 115,
        LIBPOSTAL_TOKEN_TYPE_DOUBLE_QUOTE = 119,
        LIBPOSTAL_TOKEN_TYPE_SINGLE_QUOTE = 120,
        LIBPOSTAL_TOKEN_TYPE_OPEN_QUOTE = 121,
        LIBPOSTAL_TOKEN_TYPE_CLOSE_QUOTE = 122,
        LIBPOSTAL_TOKEN_TYPE_SLASH = 124,
        LIBPOSTAL_TOKEN_TYPE_BACKSLASH = 125,
        LIBPOSTAL_TOKEN_TYPE_GREATER_THAN = 126,
        LIBPOSTAL_TOKEN_TYPE_LESS_THAN = 127,
        LIBPOSTAL_TOKEN_TYPE_OTHER = 200,
        LIBPOSTAL_TOKEN_TYPE_WHITESPACE = 300,
        LIBPOSTAL_TOKEN_TYPE_NEWLINE = 301,
        LIBPOSTAL_TOKEN_TYPE_INVALID_CHAR = 500,
    }
    enum LIBPOSTAL_TOKEN_TYPE_END = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_END;
    enum LIBPOSTAL_TOKEN_TYPE_WORD = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_WORD;
    enum LIBPOSTAL_TOKEN_TYPE_ABBREVIATION = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_ABBREVIATION;
    enum LIBPOSTAL_TOKEN_TYPE_IDEOGRAPHIC_CHAR = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_IDEOGRAPHIC_CHAR;
    enum LIBPOSTAL_TOKEN_TYPE_HANGUL_SYLLABLE = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_HANGUL_SYLLABLE;
    enum LIBPOSTAL_TOKEN_TYPE_ACRONYM = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_ACRONYM;
    enum LIBPOSTAL_TOKEN_TYPE_PHRASE = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_PHRASE;
    enum LIBPOSTAL_TOKEN_TYPE_EMAIL = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_EMAIL;
    enum LIBPOSTAL_TOKEN_TYPE_URL = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_URL;
    enum LIBPOSTAL_TOKEN_TYPE_US_PHONE = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_US_PHONE;
    enum LIBPOSTAL_TOKEN_TYPE_INTL_PHONE = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_INTL_PHONE;
    enum LIBPOSTAL_TOKEN_TYPE_NUMERIC = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_NUMERIC;
    enum LIBPOSTAL_TOKEN_TYPE_ORDINAL = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_ORDINAL;
    enum LIBPOSTAL_TOKEN_TYPE_ROMAN_NUMERAL = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_ROMAN_NUMERAL;
    enum LIBPOSTAL_TOKEN_TYPE_IDEOGRAPHIC_NUMBER = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_IDEOGRAPHIC_NUMBER;
    enum LIBPOSTAL_TOKEN_TYPE_PERIOD = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_PERIOD;
    enum LIBPOSTAL_TOKEN_TYPE_EXCLAMATION = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_EXCLAMATION;
    enum LIBPOSTAL_TOKEN_TYPE_QUESTION_MARK = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_QUESTION_MARK;
    enum LIBPOSTAL_TOKEN_TYPE_COMMA = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_COMMA;
    enum LIBPOSTAL_TOKEN_TYPE_COLON = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_COLON;
    enum LIBPOSTAL_TOKEN_TYPE_SEMICOLON = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_SEMICOLON;
    enum LIBPOSTAL_TOKEN_TYPE_PLUS = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_PLUS;
    enum LIBPOSTAL_TOKEN_TYPE_AMPERSAND = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_AMPERSAND;
    enum LIBPOSTAL_TOKEN_TYPE_AT_SIGN = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_AT_SIGN;
    enum LIBPOSTAL_TOKEN_TYPE_POUND = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_POUND;
    enum LIBPOSTAL_TOKEN_TYPE_ELLIPSIS = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_ELLIPSIS;
    enum LIBPOSTAL_TOKEN_TYPE_DASH = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_DASH;
    enum LIBPOSTAL_TOKEN_TYPE_BREAKING_DASH = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_BREAKING_DASH;
    enum LIBPOSTAL_TOKEN_TYPE_HYPHEN = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_HYPHEN;
    enum LIBPOSTAL_TOKEN_TYPE_PUNCT_OPEN = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_PUNCT_OPEN;
    enum LIBPOSTAL_TOKEN_TYPE_PUNCT_CLOSE = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_PUNCT_CLOSE;
    enum LIBPOSTAL_TOKEN_TYPE_DOUBLE_QUOTE = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_DOUBLE_QUOTE;
    enum LIBPOSTAL_TOKEN_TYPE_SINGLE_QUOTE = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_SINGLE_QUOTE;
    enum LIBPOSTAL_TOKEN_TYPE_OPEN_QUOTE = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_OPEN_QUOTE;
    enum LIBPOSTAL_TOKEN_TYPE_CLOSE_QUOTE = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_CLOSE_QUOTE;
    enum LIBPOSTAL_TOKEN_TYPE_SLASH = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_SLASH;
    enum LIBPOSTAL_TOKEN_TYPE_BACKSLASH = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_BACKSLASH;
    enum LIBPOSTAL_TOKEN_TYPE_GREATER_THAN = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_GREATER_THAN;
    enum LIBPOSTAL_TOKEN_TYPE_LESS_THAN = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_LESS_THAN;
    enum LIBPOSTAL_TOKEN_TYPE_OTHER = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_OTHER;
    enum LIBPOSTAL_TOKEN_TYPE_WHITESPACE = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_WHITESPACE;
    enum LIBPOSTAL_TOKEN_TYPE_NEWLINE = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_NEWLINE;
    enum LIBPOSTAL_TOKEN_TYPE_INVALID_CHAR = _Anonymous_0.LIBPOSTAL_TOKEN_TYPE_INVALID_CHAR;
    void* valloc(c_ulong) @nogc nothrow;
    void free(void*) @nogc nothrow;
    alias libpostal_normalize_options_t = libpostal_normalize_options;
    struct libpostal_normalize_options
    {
        char** languages;
        c_ulong num_languages;
        ushort address_components;
        bool latin_ascii;
        bool transliterate;
        bool strip_accents;
        bool decompose;
        bool lowercase;
        bool trim_string;
        bool drop_parentheticals;
        bool replace_numeric_hyphens;
        bool delete_numeric_hyphens;
        bool split_alpha_from_numeric;
        bool replace_word_hyphens;
        bool delete_word_hyphens;
        bool delete_final_periods;
        bool delete_acronym_periods;
        bool drop_english_possessives;
        bool delete_apostrophes;
        bool expand_numex;
        bool roman_numerals;
    }
    libpostal_normalize_options libpostal_get_default_options() @nogc nothrow;
    char** libpostal_expand_address(char*, libpostal_normalize_options, c_ulong*) @nogc nothrow;
    char** libpostal_expand_address_root(char*, libpostal_normalize_options, c_ulong*) @nogc nothrow;
    void libpostal_expansion_array_destroy(char**, c_ulong) @nogc nothrow;
    alias libpostal_address_parser_response_t = libpostal_address_parser_response;
    struct libpostal_address_parser_response
    {
        c_ulong num_components;
        char** components;
        char** labels;
    }
    alias libpostal_parsed_address_components_t = libpostal_address_parser_response;
    alias libpostal_address_parser_options_t = libpostal_address_parser_options;
    struct libpostal_address_parser_options
    {
        char* language;
        char* country;
    }
    void libpostal_address_parser_response_destroy(libpostal_address_parser_response*) @nogc nothrow;
    libpostal_address_parser_options libpostal_get_address_parser_default_options() @nogc nothrow;
    libpostal_address_parser_response* libpostal_parse_address(char*, libpostal_address_parser_options) @nogc nothrow;
    bool libpostal_parser_print_features(bool) @nogc nothrow;
    alias libpostal_language_classifier_response_t = libpostal_language_classifier_response;
    struct libpostal_language_classifier_response
    {
        c_ulong num_languages;
        char** languages;
        double* probs;
    }
    libpostal_language_classifier_response* libpostal_classify_language(char*) @nogc nothrow;
    void libpostal_language_classifier_response_destroy(libpostal_language_classifier_response*) @nogc nothrow;
    alias libpostal_near_dupe_hash_options_t = libpostal_near_dupe_hash_options;
    struct libpostal_near_dupe_hash_options
    {
        bool with_name;
        bool with_address;
        bool with_unit;
        bool with_city_or_equivalent;
        bool with_small_containing_boundaries;
        bool with_postal_code;
        bool with_latlon;
        double latitude;
        double longitude;
        uint geohash_precision;
        bool name_and_address_keys;
        bool name_only_keys;
        bool address_only_keys;
    }
    libpostal_near_dupe_hash_options libpostal_get_near_dupe_hash_default_options() @nogc nothrow;
    char** libpostal_near_dupe_hashes(c_ulong, char**, char**, libpostal_near_dupe_hash_options, c_ulong*) @nogc nothrow;
    char** libpostal_near_dupe_hashes_languages(c_ulong, char**, char**, libpostal_near_dupe_hash_options, c_ulong, char**, c_ulong*) @nogc nothrow;
    char** libpostal_place_languages(c_ulong, char**, char**, c_ulong*) @nogc nothrow;
    alias libpostal_duplicate_status_t = _Anonymous_1;
    enum _Anonymous_1
    {
        LIBPOSTAL_NULL_DUPLICATE_STATUS = -1,
        LIBPOSTAL_NON_DUPLICATE = 0,
        LIBPOSTAL_POSSIBLE_DUPLICATE_NEEDS_REVIEW = 3,
        LIBPOSTAL_LIKELY_DUPLICATE = 6,
        LIBPOSTAL_EXACT_DUPLICATE = 9,
    }
    enum LIBPOSTAL_NULL_DUPLICATE_STATUS = _Anonymous_1.LIBPOSTAL_NULL_DUPLICATE_STATUS;
    enum LIBPOSTAL_NON_DUPLICATE = _Anonymous_1.LIBPOSTAL_NON_DUPLICATE;
    enum LIBPOSTAL_POSSIBLE_DUPLICATE_NEEDS_REVIEW = _Anonymous_1.LIBPOSTAL_POSSIBLE_DUPLICATE_NEEDS_REVIEW;
    enum LIBPOSTAL_LIKELY_DUPLICATE = _Anonymous_1.LIBPOSTAL_LIKELY_DUPLICATE;
    enum LIBPOSTAL_EXACT_DUPLICATE = _Anonymous_1.LIBPOSTAL_EXACT_DUPLICATE;
    alias libpostal_duplicate_options_t = libpostal_duplicate_options;
    struct libpostal_duplicate_options
    {
        c_ulong num_languages;
        char** languages;
    }
    libpostal_duplicate_options libpostal_get_default_duplicate_options() @nogc nothrow;
    libpostal_duplicate_options libpostal_get_duplicate_options_with_languages(c_ulong, char**) @nogc nothrow;
    libpostal_duplicate_status_t libpostal_is_name_duplicate(char*, char*, libpostal_duplicate_options) @nogc nothrow;
    libpostal_duplicate_status_t libpostal_is_street_duplicate(char*, char*, libpostal_duplicate_options) @nogc nothrow;
    libpostal_duplicate_status_t libpostal_is_house_number_duplicate(char*, char*, libpostal_duplicate_options) @nogc nothrow;
    libpostal_duplicate_status_t libpostal_is_po_box_duplicate(char*, char*, libpostal_duplicate_options) @nogc nothrow;
    libpostal_duplicate_status_t libpostal_is_unit_duplicate(char*, char*, libpostal_duplicate_options) @nogc nothrow;
    libpostal_duplicate_status_t libpostal_is_floor_duplicate(char*, char*, libpostal_duplicate_options) @nogc nothrow;
    libpostal_duplicate_status_t libpostal_is_postal_code_duplicate(char*, char*, libpostal_duplicate_options) @nogc nothrow;
    libpostal_duplicate_status_t libpostal_is_toponym_duplicate(c_ulong, char**, char**, c_ulong, char**, char**, libpostal_duplicate_options) @nogc nothrow;
    alias libpostal_fuzzy_duplicate_options_t = libpostal_fuzzy_duplicate_options;
    struct libpostal_fuzzy_duplicate_options
    {
        c_ulong num_languages;
        char** languages;
        double needs_review_threshold;
        double likely_dupe_threshold;
    }
    alias libpostal_fuzzy_duplicate_status_t = libpostal_fuzzy_duplicate_status;
    struct libpostal_fuzzy_duplicate_status
    {
        libpostal_duplicate_status_t status;
        double similarity;
    }
    libpostal_fuzzy_duplicate_options libpostal_get_default_fuzzy_duplicate_options() @nogc nothrow;
    libpostal_fuzzy_duplicate_options libpostal_get_default_fuzzy_duplicate_options_with_languages(c_ulong, char**) @nogc nothrow;
    libpostal_fuzzy_duplicate_status libpostal_is_name_duplicate_fuzzy(c_ulong, char**, double*, c_ulong, char**, double*, libpostal_fuzzy_duplicate_options) @nogc nothrow;
    libpostal_fuzzy_duplicate_status libpostal_is_street_duplicate_fuzzy(c_ulong, char**, double*, c_ulong, char**, double*, libpostal_fuzzy_duplicate_options) @nogc nothrow;
    bool libpostal_setup() @nogc nothrow;
    bool libpostal_setup_datadir(char*) @nogc nothrow;
    void libpostal_teardown() @nogc nothrow;
    bool libpostal_setup_parser() @nogc nothrow;
    bool libpostal_setup_parser_datadir(char*) @nogc nothrow;
    void libpostal_teardown_parser() @nogc nothrow;
    bool libpostal_setup_language_classifier() @nogc nothrow;
    bool libpostal_setup_language_classifier_datadir(char*) @nogc nothrow;
    void libpostal_teardown_language_classifier() @nogc nothrow;
    alias libpostal_token_t = libpostal_token;
    struct libpostal_token
    {
        c_ulong offset;
        c_ulong len;
        ushort type;
    }
    libpostal_token* libpostal_tokenize(char*, bool, c_ulong*) @nogc nothrow;
    void* reallocarray(void*, c_ulong, c_ulong) @nogc nothrow;
    void* realloc(void*, c_ulong) @nogc nothrow;
    void* calloc(c_ulong, c_ulong) @nogc nothrow;
    void* malloc(c_ulong) @nogc nothrow;
    int lcong48_r(ushort*, drand48_data*) @nogc nothrow;
    int seed48_r(ushort*, drand48_data*) @nogc nothrow;
    char* libpostal_normalize_string_languages(char*, c_ulong, c_ulong, char**) @nogc nothrow;
    char* libpostal_normalize_string(char*, c_ulong) @nogc nothrow;
    alias libpostal_normalized_token_t = libpostal_normalized_token;
    struct libpostal_normalized_token
    {
        char* str;
        libpostal_token token;
    }
    libpostal_normalized_token* libpostal_normalized_tokens(char*, c_ulong, c_ulong, bool, c_ulong*) @nogc nothrow;
    libpostal_normalized_token* libpostal_normalized_tokens_languages(char*, c_ulong, c_ulong, bool, c_ulong, char**, c_ulong*) @nogc nothrow;
    int srand48_r(c_long, drand48_data*) @nogc nothrow;
    pragma(mangle, "alloca") void* alloca_(c_ulong) @nogc nothrow;
    int jrand48_r(ushort*, drand48_data*, c_long*) @nogc nothrow;
    static ushort __bswap_16(ushort) @nogc nothrow;
    static uint __bswap_32(uint) @nogc nothrow;
    int mrand48_r(drand48_data*, c_long*) @nogc nothrow;
    static c_ulong __bswap_64(c_ulong) @nogc nothrow;
    int nrand48_r(ushort*, drand48_data*, c_long*) @nogc nothrow;
    int lrand48_r(drand48_data*, c_long*) @nogc nothrow;
    int erand48_r(ushort*, drand48_data*, double*) @nogc nothrow;
    int drand48_r(drand48_data*, double*) @nogc nothrow;
    struct drand48_data
    {
        ushort[3] __x;
        ushort[3] __old_x;
        ushort __c;
        ushort __init;
        ulong __a;
    }
    void lcong48(ushort*) @nogc nothrow;
    ushort* seed48(ushort*) @nogc nothrow;
    void srand48(c_long) @nogc nothrow;
    c_long jrand48(ushort*) @nogc nothrow;
    c_long mrand48() @nogc nothrow;
    c_long nrand48(ushort*) @nogc nothrow;
    alias _Float32 = float;
    c_long lrand48() @nogc nothrow;
    alias _Float64 = double;
    double erand48(ushort*) @nogc nothrow;
    double drand48() @nogc nothrow;
    alias _Float32x = double;
    int rand_r(uint*) @nogc nothrow;
    alias _Float64x = real;
    void srand(uint) @nogc nothrow;
    int rand() @nogc nothrow;
    int setstate_r(char*, random_data*) @nogc nothrow;
    int initstate_r(uint, char*, c_ulong, random_data*) @nogc nothrow;
    int srandom_r(uint, random_data*) @nogc nothrow;
    int random_r(random_data*, int*) @nogc nothrow;
    struct random_data
    {
        int* fptr;
        int* rptr;
        int* state;
        int rand_type;
        int rand_deg;
        int rand_sep;
        int* end_ptr;
    }
    char* setstate(char*) @nogc nothrow;
    char* initstate(uint, char*, c_ulong) @nogc nothrow;
    void srandom(uint) @nogc nothrow;
    c_long random() @nogc nothrow;
    c_long a64l(const(char)*) @nogc nothrow;
    char* l64a(c_long) @nogc nothrow;
    alias pthread_t = c_ulong;
    union pthread_mutexattr_t
    {
        char[4] __size;
        int __align;
    }
    union pthread_condattr_t
    {
        char[4] __size;
        int __align;
    }
    alias pthread_key_t = uint;
    alias pthread_once_t = int;
    union pthread_attr_t
    {
        char[56] __size;
        c_long __align;
    }
    union pthread_mutex_t
    {
        __pthread_mutex_s __data;
        char[40] __size;
        c_long __align;
    }
    union pthread_cond_t
    {
        __pthread_cond_s __data;
        char[48] __size;
        long __align;
    }
    union pthread_rwlock_t
    {
        __pthread_rwlock_arch_t __data;
        char[56] __size;
        c_long __align;
    }
    union pthread_rwlockattr_t
    {
        char[8] __size;
        c_long __align;
    }
    alias pthread_spinlock_t = int;
    union pthread_barrier_t
    {
        char[32] __size;
        c_long __align;
    }
    union pthread_barrierattr_t
    {
        char[4] __size;
        int __align;
    }
    alias int8_t = byte;
    alias int16_t = short;
    alias int32_t = int;
    alias int64_t = c_long;
    alias uint8_t = ubyte;
    alias uint16_t = ushort;
    alias uint32_t = uint;
    alias uint64_t = ulong;
    ulong strtoull(const(char)*, char**, int) @nogc nothrow;
    struct __pthread_mutex_s
    {
        int __lock;
        uint __count;
        int __owner;
        uint __nusers;
        int __kind;
        short __spins;
        short __elision;
        __pthread_internal_list __list;
    }
    long strtoll(const(char)*, char**, int) @nogc nothrow;
    struct __pthread_rwlock_arch_t
    {
        uint __readers;
        uint __writers;
        uint __wrphase_futex;
        uint __writers_futex;
        uint __pad3;
        uint __pad4;
        int __cur_writer;
        int __shared;
        byte __rwelision;
        ubyte[7] __pad1;
        c_ulong __pad2;
        uint __flags;
    }
    extern __gshared int sys_nerr;
    extern __gshared const(const(char)*)[0] sys_errlist;
    ulong strtouq(const(char)*, char**, int) @nogc nothrow;
    alias __pthread_list_t = __pthread_internal_list;
    struct __pthread_internal_list
    {
        __pthread_internal_list* __prev;
        __pthread_internal_list* __next;
    }
    alias __pthread_slist_t = __pthread_internal_slist;
    struct __pthread_internal_slist
    {
        __pthread_internal_slist* __next;
    }
    struct __pthread_cond_s
    {
        static union _Anonymous_2
        {
            ulong __wseq;
            static struct _Anonymous_3
            {
                uint __low;
                uint __high;
            }
            _Anonymous_3 __wseq32;
        }
        _Anonymous_2 _anonymous_4;
        auto __wseq() @property @nogc pure nothrow { return _anonymous_4.__wseq; }
        void __wseq(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_4.__wseq = val; }
        auto __wseq32() @property @nogc pure nothrow { return _anonymous_4.__wseq32; }
        void __wseq32(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_4.__wseq32 = val; }
        static union _Anonymous_5
        {
            ulong __g1_start;
            static struct _Anonymous_6
            {
                uint __low;
                uint __high;
            }
            _Anonymous_6 __g1_start32;
        }
        _Anonymous_5 _anonymous_7;
        auto __g1_start() @property @nogc pure nothrow { return _anonymous_7.__g1_start; }
        void __g1_start(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_7.__g1_start = val; }
        auto __g1_start32() @property @nogc pure nothrow { return _anonymous_7.__g1_start32; }
        void __g1_start32(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_7.__g1_start32 = val; }
        uint[2] __g_refs;
        uint[2] __g_size;
        uint __g1_orig_size;
        uint __wrefs;
        uint[2] __g_signals;
    }
    long strtoq(const(char)*, char**, int) @nogc nothrow;
    alias __u_char = ubyte;
    alias __u_short = ushort;
    alias __u_int = uint;
    alias __u_long = c_ulong;
    alias __int8_t = byte;
    alias __uint8_t = ubyte;
    alias __int16_t = short;
    alias __uint16_t = ushort;
    alias __int32_t = int;
    alias __uint32_t = uint;
    alias __int64_t = c_long;
    alias __uint64_t = c_ulong;
    alias __int_least8_t = byte;
    alias __uint_least8_t = ubyte;
    alias __int_least16_t = short;
    alias __uint_least16_t = ushort;
    alias __int_least32_t = int;
    alias __uint_least32_t = uint;
    alias __int_least64_t = c_long;
    alias __uint_least64_t = c_ulong;
    alias __quad_t = c_long;
    alias __u_quad_t = c_ulong;
    alias __intmax_t = c_long;
    alias __uintmax_t = c_ulong;
    c_ulong strtoul(const(char)*, char**, int) @nogc nothrow;
    c_long strtol(const(char)*, char**, int) @nogc nothrow;
    alias __dev_t = c_ulong;
    alias __uid_t = uint;
    alias __gid_t = uint;
    alias __ino_t = c_ulong;
    alias __ino64_t = c_ulong;
    alias __mode_t = uint;
    alias __nlink_t = c_ulong;
    alias __off_t = c_long;
    alias __off64_t = c_long;
    alias __pid_t = int;
    struct __fsid_t
    {
        int[2] __val;
    }
    alias __clock_t = c_long;
    alias __rlim_t = c_ulong;
    alias __rlim64_t = c_ulong;
    alias __id_t = uint;
    alias __time_t = c_long;
    alias __useconds_t = uint;
    alias __suseconds_t = c_long;
    alias __daddr_t = int;
    alias __key_t = int;
    alias __clockid_t = int;
    alias __timer_t = void*;
    alias __blksize_t = c_long;
    alias __blkcnt_t = c_long;
    alias __blkcnt64_t = c_long;
    alias __fsblkcnt_t = c_ulong;
    alias __fsblkcnt64_t = c_ulong;
    alias __fsfilcnt_t = c_ulong;
    alias __fsfilcnt64_t = c_ulong;
    alias __fsword_t = c_long;
    alias __ssize_t = c_long;
    alias __syscall_slong_t = c_long;
    alias __syscall_ulong_t = c_ulong;
    alias __loff_t = c_long;
    alias __caddr_t = char*;
    alias __intptr_t = c_long;
    alias __socklen_t = uint;
    alias __sig_atomic_t = int;
    alias FILE = _IO_FILE;
    struct _IO_FILE
    {
        int _flags;
        char* _IO_read_ptr;
        char* _IO_read_end;
        char* _IO_read_base;
        char* _IO_write_base;
        char* _IO_write_ptr;
        char* _IO_write_end;
        char* _IO_buf_base;
        char* _IO_buf_end;
        char* _IO_save_base;
        char* _IO_backup_base;
        char* _IO_save_end;
        _IO_marker* _markers;
        _IO_FILE* _chain;
        int _fileno;
        int _flags2;
        c_long _old_offset;
        ushort _cur_column;
        byte _vtable_offset;
        char[1] _shortbuf;
        void* _lock;
        c_long _offset;
        _IO_codecvt* _codecvt;
        _IO_wide_data* _wide_data;
        _IO_FILE* _freeres_list;
        void* _freeres_buf;
        c_ulong __pad5;
        int _mode;
        char[20] _unused2;
    }
    alias __FILE = _IO_FILE;
    alias __fpos64_t = _G_fpos64_t;
    struct _G_fpos64_t
    {
        c_long __pos;
        __mbstate_t __state;
    }
    alias __fpos_t = _G_fpos_t;
    struct _G_fpos_t
    {
        c_long __pos;
        __mbstate_t __state;
    }
    struct __mbstate_t
    {
        int __count;
        static union _Anonymous_8
        {
            uint __wch;
            char[4] __wchb;
        }
        _Anonymous_8 __value;
    }
    struct __sigset_t
    {
        c_ulong[16] __val;
    }
    real strtold(const(char)*, char**) @nogc nothrow;
    alias clock_t = c_long;
    alias clockid_t = int;
    alias sigset_t = __sigset_t;
    float strtof(const(char)*, char**) @nogc nothrow;
    struct _IO_marker;
    struct _IO_codecvt;
    struct _IO_wide_data;
    alias _IO_lock_t = void;
    double strtod(const(char)*, char**) @nogc nothrow;
    struct timespec
    {
        c_long tv_sec;
        c_long tv_nsec;
    }
    long atoll(const(char)*) @nogc nothrow;
    struct timeval
    {
        c_long tv_sec;
        c_long tv_usec;
    }
    alias time_t = c_long;
    alias timer_t = void*;
    c_long atol(const(char)*) @nogc nothrow;
    int atoi(const(char)*) @nogc nothrow;
    double atof(const(char)*) @nogc nothrow;
    c_ulong __ctype_get_mb_cur_max() @nogc nothrow;
    struct lldiv_t
    {
        long quot;
        long rem;
    }
    struct ldiv_t
    {
        c_long quot;
        c_long rem;
    }
    struct div_t
    {
        int quot;
        int rem;
    }
    int __overflow(_IO_FILE*, int) @nogc nothrow;
    int __uflow(_IO_FILE*) @nogc nothrow;
    void funlockfile(_IO_FILE*) @nogc nothrow;
    static ushort __uint16_identity(ushort) @nogc nothrow;
    static uint __uint32_identity(uint) @nogc nothrow;
    static c_ulong __uint64_identity(c_ulong) @nogc nothrow;
    int ftrylockfile(_IO_FILE*) @nogc nothrow;
    void flockfile(_IO_FILE*) @nogc nothrow;
    char* ctermid(char*) @nogc nothrow;
    int pclose(_IO_FILE*) @nogc nothrow;
    _IO_FILE* popen(const(char)*, const(char)*) @nogc nothrow;
    int fileno_unlocked(_IO_FILE*) @nogc nothrow;
    int fileno(_IO_FILE*) @nogc nothrow;
    void perror(const(char)*) @nogc nothrow;
    int ferror_unlocked(_IO_FILE*) @nogc nothrow;
    int feof_unlocked(_IO_FILE*) @nogc nothrow;
    void clearerr_unlocked(_IO_FILE*) @nogc nothrow;
    int ferror(_IO_FILE*) @nogc nothrow;
    int feof(_IO_FILE*) @nogc nothrow;
    void clearerr(_IO_FILE*) @nogc nothrow;
    int fsetpos(_IO_FILE*, const(_G_fpos_t)*) @nogc nothrow;
    int fgetpos(_IO_FILE*, _G_fpos_t*) @nogc nothrow;
    c_long ftello(_IO_FILE*) @nogc nothrow;
    int fseeko(_IO_FILE*, c_long, int) @nogc nothrow;
    void rewind(_IO_FILE*) @nogc nothrow;
    c_long ftell(_IO_FILE*) @nogc nothrow;
    int fseek(_IO_FILE*, c_long, int) @nogc nothrow;
    c_ulong fwrite_unlocked(const(void)*, c_ulong, c_ulong, _IO_FILE*) @nogc nothrow;
    c_ulong fread_unlocked(void*, c_ulong, c_ulong, _IO_FILE*) @nogc nothrow;
    c_ulong fwrite(const(void)*, c_ulong, c_ulong, _IO_FILE*) @nogc nothrow;
    c_ulong fread(void*, c_ulong, c_ulong, _IO_FILE*) @nogc nothrow;
    int ungetc(int, _IO_FILE*) @nogc nothrow;
    int puts(const(char)*) @nogc nothrow;
    int fputs(const(char)*, _IO_FILE*) @nogc nothrow;
    c_long getline(char**, c_ulong*, _IO_FILE*) @nogc nothrow;
    c_long getdelim(char**, c_ulong*, int, _IO_FILE*) @nogc nothrow;
    c_long __getdelim(char**, c_ulong*, int, _IO_FILE*) @nogc nothrow;
    char* fgets(char*, int, _IO_FILE*) @nogc nothrow;
    int putw(int, _IO_FILE*) @nogc nothrow;
    int getw(_IO_FILE*) @nogc nothrow;
    int putchar_unlocked(int) @nogc nothrow;
    int putc_unlocked(int, _IO_FILE*) @nogc nothrow;
    int fputc_unlocked(int, _IO_FILE*) @nogc nothrow;
    int putchar(int) @nogc nothrow;
    int putc(int, _IO_FILE*) @nogc nothrow;
    int fputc(int, _IO_FILE*) @nogc nothrow;
    int fgetc_unlocked(_IO_FILE*) @nogc nothrow;
    int getchar_unlocked() @nogc nothrow;
    int getc_unlocked(_IO_FILE*) @nogc nothrow;
    int getchar() @nogc nothrow;
    int getc(_IO_FILE*) @nogc nothrow;
    int fgetc(_IO_FILE*) @nogc nothrow;
    int vsscanf(const(char)*, const(char)*, va_list*) @nogc nothrow;
    int vscanf(const(char)*, va_list*) @nogc nothrow;
    alias int_least8_t = byte;
    alias int_least16_t = short;
    alias int_least32_t = int;
    alias int_least64_t = c_long;
    alias uint_least8_t = ubyte;
    alias uint_least16_t = ushort;
    alias uint_least32_t = uint;
    alias uint_least64_t = c_ulong;
    alias int_fast8_t = byte;
    alias int_fast16_t = c_long;
    alias int_fast32_t = c_long;
    alias int_fast64_t = c_long;
    alias uint_fast8_t = ubyte;
    alias uint_fast16_t = c_ulong;
    alias uint_fast32_t = c_ulong;
    alias uint_fast64_t = c_ulong;
    alias intptr_t = c_long;
    int vfscanf(_IO_FILE*, const(char)*, va_list*) @nogc nothrow;
    alias uintptr_t = c_ulong;
    alias intmax_t = c_long;
    alias uintmax_t = c_ulong;
    int sscanf(const(char)*, const(char)*, ...) @nogc nothrow;
    int scanf(const(char)*, ...) @nogc nothrow;
    int fscanf(_IO_FILE*, const(char)*, ...) @nogc nothrow;
    int dprintf(int, const(char)*, ...) @nogc nothrow;
    int vdprintf(int, const(char)*, va_list*) @nogc nothrow;
    int vsnprintf(char*, c_ulong, const(char)*, va_list*) @nogc nothrow;
    int snprintf(char*, c_ulong, const(char)*, ...) @nogc nothrow;
    int vsprintf(char*, const(char)*, va_list*) @nogc nothrow;
    int vprintf(const(char)*, va_list*) @nogc nothrow;
    int vfprintf(_IO_FILE*, const(char)*, va_list*) @nogc nothrow;
    int sprintf(char*, const(char)*, ...) @nogc nothrow;
    int printf(const(char)*, ...) @nogc nothrow;
    int fprintf(_IO_FILE*, const(char)*, ...) @nogc nothrow;
    void setlinebuf(_IO_FILE*) @nogc nothrow;
    void setbuffer(_IO_FILE*, char*, c_ulong) @nogc nothrow;
    int setvbuf(_IO_FILE*, char*, int, c_ulong) @nogc nothrow;
    void setbuf(_IO_FILE*, char*) @nogc nothrow;
    _IO_FILE* open_memstream(char**, c_ulong*) @nogc nothrow;
    _IO_FILE* fmemopen(void*, c_ulong, const(char)*) @nogc nothrow;
    _IO_FILE* fdopen(int, const(char)*) @nogc nothrow;
    _IO_FILE* freopen(const(char)*, const(char)*, _IO_FILE*) @nogc nothrow;
    _IO_FILE* fopen(const(char)*, const(char)*) @nogc nothrow;
    int fflush_unlocked(_IO_FILE*) @nogc nothrow;
    int fflush(_IO_FILE*) @nogc nothrow;
    int fclose(_IO_FILE*) @nogc nothrow;
    char* tempnam(const(char)*, const(char)*) @nogc nothrow;
    char* tmpnam_r(char*) @nogc nothrow;
    alias off_t = c_long;
    alias ssize_t = c_long;
    alias fpos_t = _G_fpos_t;
    char* tmpnam(char*) @nogc nothrow;
    _IO_FILE* tmpfile() @nogc nothrow;
    int renameat(int, const(char)*, int, const(char)*) @nogc nothrow;
    int rename(const(char)*, const(char)*) @nogc nothrow;
    extern __gshared _IO_FILE* stdin;
    extern __gshared _IO_FILE* stdout;
    extern __gshared _IO_FILE* stderr;
    int remove(const(char)*) @nogc nothrow;
    static if(!is(typeof(P_tmpdir))) {
        enum P_tmpdir = "/tmp";
    }




    static if(!is(typeof(SEEK_END))) {
        enum SEEK_END = 2;
    }




    static if(!is(typeof(SEEK_CUR))) {
        enum SEEK_CUR = 1;
    }




    static if(!is(typeof(SEEK_SET))) {
        enum SEEK_SET = 0;
    }






    static if(!is(typeof(BUFSIZ))) {
        enum BUFSIZ = 8192;
    }




    static if(!is(typeof(_IONBF))) {
        enum _IONBF = 2;
    }




    static if(!is(typeof(_IOLBF))) {
        enum _IOLBF = 1;
    }




    static if(!is(typeof(_IOFBF))) {
        enum _IOFBF = 0;
    }
    static if(!is(typeof(_STDIO_H))) {
        enum _STDIO_H = 1;
    }
    static if(!is(typeof(_STDINT_H))) {
        enum _STDINT_H = 1;
    }




    static if(!is(typeof(_STDC_PREDEF_H))) {
        enum _STDC_PREDEF_H = 1;
    }
    static if(!is(typeof(__GLIBC_MINOR__))) {
        enum __GLIBC_MINOR__ = 31;
    }




    static if(!is(typeof(__GLIBC__))) {
        enum __GLIBC__ = 2;
    }




    static if(!is(typeof(__GNU_LIBRARY__))) {
        enum __GNU_LIBRARY__ = 6;
    }




    static if(!is(typeof(__GLIBC_USE_DEPRECATED_SCANF))) {
        enum __GLIBC_USE_DEPRECATED_SCANF = 0;
    }




    static if(!is(typeof(__GLIBC_USE_DEPRECATED_GETS))) {
        enum __GLIBC_USE_DEPRECATED_GETS = 0;
    }




    static if(!is(typeof(__USE_FORTIFY_LEVEL))) {
        enum __USE_FORTIFY_LEVEL = 0;
    }




    static if(!is(typeof(__USE_ATFILE))) {
        enum __USE_ATFILE = 1;
    }




    static if(!is(typeof(__USE_MISC))) {
        enum __USE_MISC = 1;
    }




    static if(!is(typeof(_ATFILE_SOURCE))) {
        enum _ATFILE_SOURCE = 1;
    }




    static if(!is(typeof(__USE_XOPEN2K8))) {
        enum __USE_XOPEN2K8 = 1;
    }




    static if(!is(typeof(__USE_ISOC99))) {
        enum __USE_ISOC99 = 1;
    }




    static if(!is(typeof(__USE_ISOC95))) {
        enum __USE_ISOC95 = 1;
    }




    static if(!is(typeof(__USE_XOPEN2K))) {
        enum __USE_XOPEN2K = 1;
    }




    static if(!is(typeof(__USE_POSIX199506))) {
        enum __USE_POSIX199506 = 1;
    }




    static if(!is(typeof(__USE_POSIX199309))) {
        enum __USE_POSIX199309 = 1;
    }




    static if(!is(typeof(__USE_POSIX2))) {
        enum __USE_POSIX2 = 1;
    }




    static if(!is(typeof(__USE_POSIX))) {
        enum __USE_POSIX = 1;
    }




    static if(!is(typeof(_POSIX_C_SOURCE))) {
        enum _POSIX_C_SOURCE = 200809L;
    }




    static if(!is(typeof(_POSIX_SOURCE))) {
        enum _POSIX_SOURCE = 1;
    }




    static if(!is(typeof(__USE_POSIX_IMPLICITLY))) {
        enum __USE_POSIX_IMPLICITLY = 1;
    }




    static if(!is(typeof(__USE_ISOC11))) {
        enum __USE_ISOC11 = 1;
    }




    static if(!is(typeof(__GLIBC_USE_ISOC2X))) {
        enum __GLIBC_USE_ISOC2X = 0;
    }




    static if(!is(typeof(_DEFAULT_SOURCE))) {
        enum _DEFAULT_SOURCE = 1;
    }
    static if(!is(typeof(_FEATURES_H))) {
        enum _FEATURES_H = 1;
    }
    static if(!is(typeof(_ENDIAN_H))) {
        enum _ENDIAN_H = 1;
    }




    static if(!is(typeof(__SYSCALL_WORDSIZE))) {
        enum __SYSCALL_WORDSIZE = 64;
    }




    static if(!is(typeof(__WORDSIZE_TIME64_COMPAT32))) {
        enum __WORDSIZE_TIME64_COMPAT32 = 1;
    }




    static if(!is(typeof(__WORDSIZE))) {
        enum __WORDSIZE = 64;
    }
    static if(!is(typeof(_BITS_WCHAR_H))) {
        enum _BITS_WCHAR_H = 1;
    }




    static if(!is(typeof(__WCOREFLAG))) {
        enum __WCOREFLAG = 0x80;
    }




    static if(!is(typeof(__W_CONTINUED))) {
        enum __W_CONTINUED = 0xffff;
    }
    static if(!is(typeof(__WCLONE))) {
        enum __WCLONE = 0x80000000;
    }




    static if(!is(typeof(__WALL))) {
        enum __WALL = 0x40000000;
    }




    static if(!is(typeof(__WNOTHREAD))) {
        enum __WNOTHREAD = 0x20000000;
    }




    static if(!is(typeof(WNOWAIT))) {
        enum WNOWAIT = 0x01000000;
    }




    static if(!is(typeof(WCONTINUED))) {
        enum WCONTINUED = 8;
    }




    static if(!is(typeof(WEXITED))) {
        enum WEXITED = 4;
    }




    static if(!is(typeof(WSTOPPED))) {
        enum WSTOPPED = 2;
    }




    static if(!is(typeof(WUNTRACED))) {
        enum WUNTRACED = 2;
    }




    static if(!is(typeof(WNOHANG))) {
        enum WNOHANG = 1;
    }




    static if(!is(typeof(_BITS_UINTN_IDENTITY_H))) {
        enum _BITS_UINTN_IDENTITY_H = 1;
    }




    static if(!is(typeof(__FD_SETSIZE))) {
        enum __FD_SETSIZE = 1024;
    }




    static if(!is(typeof(__STATFS_MATCHES_STATFS64))) {
        enum __STATFS_MATCHES_STATFS64 = 1;
    }




    static if(!is(typeof(__RLIM_T_MATCHES_RLIM64_T))) {
        enum __RLIM_T_MATCHES_RLIM64_T = 1;
    }




    static if(!is(typeof(__INO_T_MATCHES_INO64_T))) {
        enum __INO_T_MATCHES_INO64_T = 1;
    }




    static if(!is(typeof(__OFF_T_MATCHES_OFF64_T))) {
        enum __OFF_T_MATCHES_OFF64_T = 1;
    }
    static if(!is(typeof(_STDLIB_H))) {
        enum _STDLIB_H = 1;
    }
    static if(!is(typeof(__ldiv_t_defined))) {
        enum __ldiv_t_defined = 1;
    }
    static if(!is(typeof(__lldiv_t_defined))) {
        enum __lldiv_t_defined = 1;
    }




    static if(!is(typeof(RAND_MAX))) {
        enum RAND_MAX = 2147483647;
    }




    static if(!is(typeof(EXIT_FAILURE))) {
        enum EXIT_FAILURE = 1;
    }




    static if(!is(typeof(EXIT_SUCCESS))) {
        enum EXIT_SUCCESS = 0;
    }
    static if(!is(typeof(_BITS_TYPESIZES_H))) {
        enum _BITS_TYPESIZES_H = 1;
    }




    static if(!is(typeof(__timer_t_defined))) {
        enum __timer_t_defined = 1;
    }




    static if(!is(typeof(__time_t_defined))) {
        enum __time_t_defined = 1;
    }




    static if(!is(typeof(__timeval_defined))) {
        enum __timeval_defined = 1;
    }




    static if(!is(typeof(_STRUCT_TIMESPEC))) {
        enum _STRUCT_TIMESPEC = 1;
    }




    static if(!is(typeof(_IO_USER_LOCK))) {
        enum _IO_USER_LOCK = 0x8000;
    }






    static if(!is(typeof(_IO_ERR_SEEN))) {
        enum _IO_ERR_SEEN = 0x0020;
    }






    static if(!is(typeof(_IO_EOF_SEEN))) {
        enum _IO_EOF_SEEN = 0x0010;
    }
    static if(!is(typeof(__struct_FILE_defined))) {
        enum __struct_FILE_defined = 1;
    }




    static if(!is(typeof(__sigset_t_defined))) {
        enum __sigset_t_defined = 1;
    }




    static if(!is(typeof(__clockid_t_defined))) {
        enum __clockid_t_defined = 1;
    }




    static if(!is(typeof(__clock_t_defined))) {
        enum __clock_t_defined = 1;
    }
    static if(!is(typeof(____mbstate_t_defined))) {
        enum ____mbstate_t_defined = 1;
    }




    static if(!is(typeof(_____fpos_t_defined))) {
        enum _____fpos_t_defined = 1;
    }




    static if(!is(typeof(_____fpos64_t_defined))) {
        enum _____fpos64_t_defined = 1;
    }




    static if(!is(typeof(____FILE_defined))) {
        enum ____FILE_defined = 1;
    }




    static if(!is(typeof(__FILE_defined))) {
        enum __FILE_defined = 1;
    }
    static if(!is(typeof(_BITS_TYPES_H))) {
        enum _BITS_TYPES_H = 1;
    }
    static if(!is(typeof(_BITS_TIME64_H))) {
        enum _BITS_TIME64_H = 1;
    }




    static if(!is(typeof(_THREAD_SHARED_TYPES_H))) {
        enum _THREAD_SHARED_TYPES_H = 1;
    }
    static if(!is(typeof(__PTHREAD_MUTEX_HAVE_PREV))) {
        enum __PTHREAD_MUTEX_HAVE_PREV = 1;
    }




    static if(!is(typeof(_THREAD_MUTEX_INTERNAL_H))) {
        enum _THREAD_MUTEX_INTERNAL_H = 1;
    }




    static if(!is(typeof(FOPEN_MAX))) {
        enum FOPEN_MAX = 16;
    }




    static if(!is(typeof(L_ctermid))) {
        enum L_ctermid = 9;
    }




    static if(!is(typeof(FILENAME_MAX))) {
        enum FILENAME_MAX = 4096;
    }




    static if(!is(typeof(TMP_MAX))) {
        enum TMP_MAX = 238328;
    }




    static if(!is(typeof(L_tmpnam))) {
        enum L_tmpnam = 20;
    }




    static if(!is(typeof(_BITS_STDIO_LIM_H))) {
        enum _BITS_STDIO_LIM_H = 1;
    }




    static if(!is(typeof(_BITS_STDINT_UINTN_H))) {
        enum _BITS_STDINT_UINTN_H = 1;
    }




    static if(!is(typeof(_BITS_STDINT_INTN_H))) {
        enum _BITS_STDINT_INTN_H = 1;
    }
    static if(!is(typeof(__FD_ZERO_STOS))) {
        enum __FD_ZERO_STOS = "stosq";
    }




    static if(!is(typeof(__have_pthread_attr_t))) {
        enum __have_pthread_attr_t = 1;
    }




    static if(!is(typeof(_BITS_PTHREADTYPES_COMMON_H))) {
        enum _BITS_PTHREADTYPES_COMMON_H = 1;
    }
    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIERATTR_T))) {
        enum __SIZEOF_PTHREAD_BARRIERATTR_T = 4;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCKATTR_T))) {
        enum __SIZEOF_PTHREAD_RWLOCKATTR_T = 8;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_CONDATTR_T))) {
        enum __SIZEOF_PTHREAD_CONDATTR_T = 4;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_COND_T))) {
        enum __SIZEOF_PTHREAD_COND_T = 48;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEXATTR_T))) {
        enum __SIZEOF_PTHREAD_MUTEXATTR_T = 4;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIER_T))) {
        enum __SIZEOF_PTHREAD_BARRIER_T = 32;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCK_T))) {
        enum __SIZEOF_PTHREAD_RWLOCK_T = 56;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_ATTR_T))) {
        enum __SIZEOF_PTHREAD_ATTR_T = 56;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEX_T))) {
        enum __SIZEOF_PTHREAD_MUTEX_T = 40;
    }




    static if(!is(typeof(_BITS_PTHREADTYPES_ARCH_H))) {
        enum _BITS_PTHREADTYPES_ARCH_H = 1;
    }




    static if(!is(typeof(__LONG_DOUBLE_USES_FLOAT128))) {
        enum __LONG_DOUBLE_USES_FLOAT128 = 0;
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_TYPES_EXT))) {
        enum __GLIBC_USE_IEC_60559_TYPES_EXT = 0;
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_FUNCS_EXT_C2X))) {
        enum __GLIBC_USE_IEC_60559_FUNCS_EXT_C2X = 0;
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_FUNCS_EXT))) {
        enum __GLIBC_USE_IEC_60559_FUNCS_EXT = 0;
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_BFP_EXT_C2X))) {
        enum __GLIBC_USE_IEC_60559_BFP_EXT_C2X = 0;
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_BFP_EXT))) {
        enum __GLIBC_USE_IEC_60559_BFP_EXT = 0;
    }




    static if(!is(typeof(__GLIBC_USE_LIB_EXT2))) {
        enum __GLIBC_USE_LIB_EXT2 = 0;
    }




    static if(!is(typeof(__HAVE_FLOAT64X_LONG_DOUBLE))) {
        enum __HAVE_FLOAT64X_LONG_DOUBLE = 1;
    }




    static if(!is(typeof(__HAVE_FLOAT64X))) {
        enum __HAVE_FLOAT64X = 1;
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT128))) {
        enum __HAVE_DISTINCT_FLOAT128 = 0;
    }




    static if(!is(typeof(__HAVE_FLOAT128))) {
        enum __HAVE_FLOAT128 = 0;
    }
    static if(!is(typeof(__HAVE_FLOATN_NOT_TYPEDEF))) {
        enum __HAVE_FLOATN_NOT_TYPEDEF = 0;
    }
    static if(!is(typeof(__HAVE_DISTINCT_FLOAT64X))) {
        enum __HAVE_DISTINCT_FLOAT64X = 0;
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT32X))) {
        enum __HAVE_DISTINCT_FLOAT32X = 0;
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT64))) {
        enum __HAVE_DISTINCT_FLOAT64 = 0;
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT32))) {
        enum __HAVE_DISTINCT_FLOAT32 = 0;
    }






    static if(!is(typeof(__HAVE_FLOAT128X))) {
        enum __HAVE_FLOAT128X = 0;
    }




    static if(!is(typeof(__HAVE_FLOAT32X))) {
        enum __HAVE_FLOAT32X = 1;
    }




    static if(!is(typeof(__HAVE_FLOAT64))) {
        enum __HAVE_FLOAT64 = 1;
    }




    static if(!is(typeof(__HAVE_FLOAT32))) {
        enum __HAVE_FLOAT32 = 1;
    }




    static if(!is(typeof(__HAVE_FLOAT16))) {
        enum __HAVE_FLOAT16 = 0;
    }
    static if(!is(typeof(_BITS_ENDIANNESS_H))) {
        enum _BITS_ENDIANNESS_H = 1;
    }
    static if(!is(typeof(__PDP_ENDIAN))) {
        enum __PDP_ENDIAN = 3412;
    }




    static if(!is(typeof(__BIG_ENDIAN))) {
        enum __BIG_ENDIAN = 4321;
    }




    static if(!is(typeof(__LITTLE_ENDIAN))) {
        enum __LITTLE_ENDIAN = 1234;
    }




    static if(!is(typeof(_BITS_ENDIAN_H))) {
        enum _BITS_ENDIAN_H = 1;
    }
    static if(!is(typeof(_BITS_BYTESWAP_H))) {
        enum _BITS_BYTESWAP_H = 1;
    }






    static if(!is(typeof(_ALLOCA_H))) {
        enum _ALLOCA_H = 1;
    }
    static if(!is(typeof(LIBPOSTAL_ADDRESS_NONE))) {
        enum LIBPOSTAL_ADDRESS_NONE = 0;
    }




    static if(!is(typeof(LIBPOSTAL_MAX_LANGUAGE_LEN))) {
        enum LIBPOSTAL_MAX_LANGUAGE_LEN = 4;
    }
    static if(!is(typeof(_SYS_CDEFS_H))) {
        enum _SYS_CDEFS_H = 1;
    }
    static if(!is(typeof(__glibc_c99_flexarr_available))) {
        enum __glibc_c99_flexarr_available = 1;
    }
    static if(!is(typeof(__HAVE_GENERIC_SELECTION))) {
        enum __HAVE_GENERIC_SELECTION = 1;
    }




    static if(!is(typeof(_SYS_SELECT_H))) {
        enum _SYS_SELECT_H = 1;
    }
    static if(!is(typeof(_SYS_TYPES_H))) {
        enum _SYS_TYPES_H = 1;
    }
    static if(!is(typeof(__BIT_TYPES_DEFINED__))) {
        enum __BIT_TYPES_DEFINED__ = 1;
    }
    static if(!is(typeof(__GNUC_VA_LIST))) {
        enum __GNUC_VA_LIST = 1;
    }
    static if(!is(typeof(true_))) {
        enum true_ = 1;
    }




    static if(!is(typeof(false_))) {
        enum false_ = 0;
    }




    static if(!is(typeof(__bool_true_false_are_defined))) {
        enum __bool_true_false_are_defined = 1;
    }
}


struct __va_list_tag;
