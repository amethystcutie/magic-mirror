<script>
import Page from "#lib/Page.svelte";
import {contacts} from "#lib/chats.ts";
</script>

<Page>
    <h1 class="text-3xl font-bold">magic mirror</h1>

    <div class="w-full flex-1 overflow-y-auto scrollbar-none flex flex-col gap-3">
        {#each contacts as contact}
            <a href="chat">
                <div class="gap-3 card bg-base-200 p-3 hover:bg-base-300 hover:shadow-sm duration-250 transition-all flex flex-row">
                    <div class="avatar avatar-placeholder text-xl text-accent-content font-bold">
                        <div class="w-12 rounded-full" style="background-color: {contact.colour}">
                            <p>{contact.name[0]}</p>
                        </div>
                    </div>
                    <div class="flex flex-col overflow-hidden">
                        <span class="font-bold text-lg">{contact.name}</span>
                        <span class="text-gray-400 mask-r-from-90% truncate text-ellipsis">You: Lorem ipsum dolor sit amet, consectetur adipisicing elit.</span>
                    </div>

                </div>
            </a>
        {/each}
    </div>
</Page>