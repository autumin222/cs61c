#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    node* h = head;
    node* t = head;
    while(h != NULL){
        if(h->next == NULL) break;
        h = h->next->next;
        t = t->next;
        if(h == t) return 1;
    }
    return 0;
}