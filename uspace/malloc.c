
#include "malloc.h"
#include "process.h"

// this is the struct for the linked list
// the struct used for hte node
typedef struct node {
    int size;
    struct node *prev;
    struct node *next;
    int free;
    void *pt_data;
} node;




#define NODE_SIZE (((sizeof(node)) + (8 - 1)) & ~(8 - 1))
// this is used for alingmnet
#define ALIGNMENT 8  

// this creates the first node of the linked list
node *head = NULL;

// Function to align sizes to the nearest multiple of 8
size_t align(size_t size) {
    return (size + ALIGNMENT - 1) & ~(ALIGNMENT - 1);
}

// finished
void free(void *ptr) {
    // if the pointer is null already return NULL
    if (ptr == NULL)
    {
        // will do nothing and just reeturn
        return;
    }
    //creates a new node to loop through thel inked list
    node * current = head;
    // while loop to loop through the lsit
    while (current != NULL)
    {   
        // checks if that current pt_data is equal to requested pointer
        // if it is then
        if (current->pt_data == ptr)
        {
            // sets the current to free -- this means sets to 1
            // current = 1 so that node is free
            current->free = 1;
            break;
        }
        current = current->next;
    }

    // this will break out and just return
    return;

}


// finished
void *malloc(uint64_t numbytes) {
    // if the number of bytes is 0 then return NULL
    if (numbytes == 0) {
        return NULL;
    }

    // this will align number of bytes
    numbytes = align(numbytes);

    // this is the total size
    uint64_t total_size = numbytes + NODE_SIZE;

    // this checks if numbytes is greater than the max amount of energy
    if (numbytes > (0xffffffffffffffff - (uint64_t) NODE_SIZE))
    {
        return NULL;
    }

    // this will first create a node equal to head
    // allows for while loop
    node *current = head;

    // this will store the block found
    node *found = NULL;

    // searches for a free or suitable block
    while (current != NULL) {
        // this checks if found a free and greater than number of bytes
        if (current->free == 1 && (uint64_t) current->size >= total_size) {
            // puts this empty block in found node
            found = current;
            break;
        }
        current = current->next;
    }
    // this breaks out of while loop if found a block bigger
    // this means it found something bigger or same size
    // this if statement is for block splitting
    if (found != NULL) {
        // see if the found block is much bigger than needed
        // if it is then split it
        if (found->size - total_size >= NODE_SIZE) {
            // this creates the second block
            // this tells the starting address of the new block
            // the new block has a new starting address
            node *new_node = (node *)((char *)found + total_size);
            new_node->size = found->size - total_size;
            new_node->prev = found;
            // this sets the node to free
            new_node->free = 1;
            new_node->next = found->next;

            // this sets the data pointer to after new_node
            new_node->pt_data = (char *)new_node + NODE_SIZE;

            // we need to set the next node after new_node to prev to point back to new node
            if (found->next != NULL) {
                // this sets the pointer of the previous node
                found->next->prev = new_node;
            }
            found->next = new_node;
            found->size = numbytes;
        }
        // this fills up the first block
        // this changes the node to not free
        found->free = 0;
        //return (char *)found + NODE_SIZE;
        return found->pt_data;
    }

    // this exits out of the if statement if it couldn't find a suitable block
    // if found is NULL then have to do heap expansion

    // heap expansion
    // create a node for expanding the heap
    node *expanded = sbrk(total_size);
    // if sbrk did not work then return NULL
    if (expanded == (void *)-1) {
        return NULL;
    }

    // if expanded node assigns the size to numbytes
    // expanded size = num bytes
    expanded->size = numbytes;
    // makes the node not free
    expanded->free = 0;
    // expanded pt_data is equal to size of expanded + metadata
    expanded->pt_data = (char*)expanded + NODE_SIZE;
    // sets to end NULL since last node
    expanded->next = NULL;
    // if no list has been created then make first
    // make first node in linked list
    if (head == NULL)
    {
        expanded->prev = NULL;
    }
    else
    {
        expanded->prev = head;
    }

    // if no list has been created then make first
    if (head == NULL) {
        head = expanded;
    } else {
        // if list exists then have to find the last one
        node *last = head;
        // this while loop finds the last one
        while (last->next != NULL) {
            last = last->next;
        }
        last->next = expanded;
        expanded->prev = last;
    }

    // returns the node point data
    return expanded->pt_data;
}


void * calloc(uint64_t num, uint64_t sz) {
    // edge case if num or sz is equal to 0, then calloc returns NULL
    //sz or num == 0
    // size or num is 0
    if (num == 0 || sz == 0)
    {
        return NULL;
    }
    // this creates a pointer called total
    uint64_t total = num * sz;
    // creates pointer
    void* pointer = NULL;
    // this checks if the number of bytes allocated is greater than total space available
    // checks max - node size divided by size
    // the second parts tells how many nums you can possibly have
    if (num > (0xffffffffffffffff - NODE_SIZE)/sz)
    {
        return NULL;
    }
    else
    {
        // malloc a certain total
        pointer = malloc(total);
        //this if the pointer is empty
        // this goes in if the pointer is NULL
        if (pointer != NULL){
            // this sets pointer to be 0 for total size if null pointer
            memset(pointer, 0, total);
        }
    }
    
    return pointer;
}

void * realloc(void * ptr, uint64_t sz) {
    // this checks if size is 0
    // if size is 0 then returns null
    if (sz == 0)
    {
        // if ptr not null then free ptr
        if (ptr != NULL)
        {
            // frees the pointer and reeturn NULL
            free(ptr);
            return NULL;
        }
    }

    // this checks if the ptr is null
    // if pointer is NULL then call malloc
    if (ptr == NULL)
    {
        // if it is then just returns the malloc
        return malloc(sz);
    }
    // creates a new node
    node *new_node = NULL;

    //we need to check the metadata or the size of the ptr 
    // use arithmetic pointer addition to subtract
    // this brings us to header
    node *header = (node*)(uint64_t) ptr - NODE_SIZE;

    // check if the the size is less than header size
    if (sz < (uint64_t) header->size)
    {
        return ptr;
    }

    
    // if the sz is greater than the pointer size
    // if the new size is greater than old size
    if (sz > (uint64_t) header->size)
    {
        // if the requested size is greater than all the memory
        // the second part finds the max size it can be
        if (sz > (0xffffffffffffffff - (uint64_t) NODE_SIZE))
        {
            return NULL;
        }
        // this mallocs new space for the new node
        // mallocs space for new size
        new_node = malloc(sz);
        // if malloc space then moves on
        if (new_node == NULL)
        {
            return NULL;
        }

        // copies the ptr stuff to the new location new_node
        memcpy(new_node, ptr, header->size);
        // free the old location
        free(ptr);
    }
    

    // returns the new location
    return new_node;

}

// finished
void defrag() {
    // creates a node to loop through the linked list
    node *current = head;
    
    while (current != NULL && current->next != NULL) {
        // checks if the current one is free 
        // checks if then ext one is free
        if (current->free == 1 && current->next->free == 1) {
            // this goes in here when the current node is free
            // and the nexto ne is free need to merge these two niodes
            // creates a new node to store the next one
            node *next = current->next;
            // creates the new size for the node
            // adds the size of the current + next size
            current->size += next->size;  

            // this will change the current next to be the next next
            current->next = next->next;

            // this is needed for the doubly linked list
            // that means something after next
            if (next->next != NULL) {
                // sets the previous one to it before
                // sets the next next previous to be the current one
                next->next->prev = current;
            }
        } else {
            //that means just move on
            current = current->next;
        }
    }
}

int heap_info(heap_info_struct *info) {
    // if the info struct is empty
    // if (info == NULL) 
    // {
    //     return -1;
    // }

    // this is for all the counters
    // this is for the number of allocation
    int num_allocs = 0;
    // this counts how much free space available
    // it is used for free_space
    int total_free_space = 0;

    // this is for the largest free_chunk
    int largest_free_chunk = 0;

    long * size_array = NULL;
    // allocates for array
    void **ptr_array = NULL;
    // Traverse the list to gather data
    node *current = head;

    while (current != NULL) {
        if (current->free) {
            // this counts the total_free_space available
            total_free_space += current->size;
            // this compares the largest_free chunk
            if (current->size > largest_free_chunk) {
                // keeps on comparing the largest free chunk
                largest_free_chunk = current->size;
            }
        } else if (current->free == 0) {
            // this counts for how much allocations has been made
            // or non free nodes
            num_allocs++;
        }
        current = current->next;
    }

    // This will set the fields for the heap-info struct
    // this will set the fields for heap-info struct
    
    info->free_space = total_free_space;
    info->largest_free_chunk = largest_free_chunk;

    // if there are no allocations then arrays are null
    if (num_allocs == 0)
    {
        // defines the array
        info->size_array = NULL;
        info->ptr_array = NULL;
        return 0;

    }

    //info->num_allocs = num_allocs;

    // after this while loop, you have largest free chunk, free space and num_allocs

    // allocates space for the array
    info->size_array = (long *)malloc((uint64_t) num_allocs * sizeof(long *));
    // allocates for array
    info->ptr_array = malloc(num_allocs * sizeof(uintptr_t));

    // if cannot malloc space correctly
    // returns -1
    if (info->ptr_array == NULL || info->size_array == NULL)
    {
        return -1;
    }

    // This will fill out the array
    // current node is equal to the head
    //current = head;
    // this is for index

    int index = 0;
    //loop through the while loop
    while (current != NULL) {
        if (!current->free) {
            // this assigns array for the current size
            info->size_array[index] = current->size;
            // this puts the ptr array to the pt_data
            // puts the pointer
            info->ptr_array[index] = current->pt_data;
            // this does index + 1
            index= index+1;
        }
        current = current->next;
    }

    // This will sort the arrays based on descending order
    // this is for buble sort
    for (int i = 0; i < num_allocs - 1; i++) {
        for (int j = 0; j < num_allocs - i - 1; j++) {
            // this compares the size array between current and the next one
            if (info->size_array[j] < info->size_array[j + 1]) {

                long temp_size = info->size_array[j];
                void *temp_ptr = info->ptr_array[j];
                // this will flip the next and other one next to each other
                info->size_array[j] = info->size_array[j + 1];
                info->ptr_array[j] = info->ptr_array[j + 1];
                // this will also change ptr_array
                info->size_array[j + 1] = temp_size;
                info->ptr_array[j + 1] = temp_ptr;
            }
        }
    }

    // returns a 0 if successful
    return 0; 
}



