#include <ruby.h>

void Init_trie_radix_tree_ext(void);
void search_recursive(VALUE node, int letter, int *current_row, VALUE results);
VALUE search_ext(VALUE self, VALUE _from, VALUE _from_len, VALUE trie_node,
				VALUE _max_distance, VALUE _insertion_cost,
				VALUE _deletion_cost, VALUE _substitution_cost);

#define MIN2(a, b) (((a) < (b)) ? (a) : (b))
#define MIN3(a, b, c) (MIN2(MIN2((a), (b)), (c)))

#define MALLOC_W(ptr, size) do { \
	ptr = malloc(size);          \
	if (!ptr)                    \
		rb_memerror();           \
} while (0)

// Declare the variables that don't change as global, so that we don't have to pass them around
// in our recursive function and increase the stack frame unnecessarily
int *from, from_len;
int max_distance, insertion_cost, deletion_cost, substitution_cost;

void Init_trie_radix_tree_ext(void) {

	VALUE StringMetric     = rb_define_module("StringMetric");
	VALUE Levenshtein      = rb_define_module_under(StringMetric, "Levenshtein");
	VALUE TrieRadixTreeExt = rb_define_class_under(Levenshtein, "TrieRadixTreeExt", rb_cObject);

	rb_define_singleton_method(TrieRadixTreeExt, "trie_ext", search_ext, 7);
}

VALUE search_ext(VALUE self, VALUE _from, VALUE _from_len, VALUE trie_node,
				VALUE _max_distance,  VALUE _insertion_cost,
				VALUE _deletion_cost, VALUE _substitution_cost)
{
	int i, *current_row;
	VALUE results, letter, node, children, children_keys;

	// Convert from ruby types
	max_distance      = FIX2INT(_max_distance);
	insertion_cost    = FIX2INT(_insertion_cost);
	deletion_cost     = FIX2INT(_deletion_cost);
	substitution_cost = FIX2INT(_substitution_cost);
	from_len          = FIX2INT(_from_len);

	// The '_from' word is passed as an array of codepoints. Allocate memory and populate the C array
	MALLOC_W(from, from_len * sizeof(int));
	for (i = 0; i < from_len; i++)
		from[i] = FIX2INT(rb_ary_entry(_from, i));

	// Create a hash to store the results and return it to ruby when we are done
	results = rb_hash_new();

	MALLOC_W(current_row, (from_len + 1) * sizeof(int));
	for (i = 0; i <= from_len; i++)
		current_row[i] = i;

	// Extract the hash from trie_node object and get an array of keys
	children = rb_funcall(trie_node, rb_intern("children"), 0);
	children_keys = rb_funcall(children, rb_intern("keys"), 0);

	for (i = 0; i < RARRAY_LEN(children_keys); i++) {
		letter = rb_ary_entry(children_keys, i);
		node = rb_hash_aref(children, letter);
		search_recursive(node, FIX2INT(letter), current_row, results);
	}
	free(from);
	free(current_row);
	return results;
}

void search_recursive(VALUE node, int letter, int *previous_row, VALUE results) {

	int i, min, columns, distance, *current_row;
	int cost, insert_cost, delete_cost, replace_cost;
	VALUE word, codepoint, children, children_keys;

	columns = from_len + 1;
	MALLOC_W(current_row, columns * sizeof(int));
	current_row[0] = previous_row[0] + 1;

	for (i = 1; i < columns; i++) {
		cost = (from[i - 1] == letter) ? 0 : substitution_cost;
		insert_cost  = current_row[i - 1]  + insertion_cost;
		delete_cost  = previous_row[i]     + deletion_cost;
		replace_cost = previous_row[i - 1] + cost;

		current_row[i] = MIN3(insert_cost, delete_cost, replace_cost);
	}
	distance = current_row[columns - 1];
	word = rb_funcall(node, rb_intern("word"), 0);

	if (distance <= max_distance && word != Qnil)
		rb_hash_aset(results, word, INT2FIX(distance));

	min = current_row[0];
	for (i = 1; i < columns; i++)
		if (current_row[i] < min)
			min = current_row[i];

	if (min <= max_distance) {
		children = rb_funcall(node, rb_intern("children"), 0);
		children_keys = rb_funcall(children, rb_intern("keys"), 0);

		for (i = 0; i < RARRAY_LEN(children_keys); i++) {
			codepoint = rb_ary_entry(children_keys, i);
			node = rb_hash_aref(children, codepoint);
			search_recursive(node, FIX2INT(codepoint), current_row, results);
		}
	}
	free(current_row);
}
